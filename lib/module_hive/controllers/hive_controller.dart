import 'dart:async';
import 'package:chatin/module_chat/index.dart';
import 'package:chatin/module_common/models/person_user.dart';
import 'package:chatin/module_hive/adapters/chat_hive.dart';
import 'package:chatin/module_hive/adapters/chat_message_field_hive.dart';
import 'package:chatin/module_hive/adapters/chat_message_hive.dart';
import 'package:chatin/module_hive/adapters/chat_metadata_hive.dart';
import 'package:chatin/repositories/personuser_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';

class HiveController{
  static const String _chatNameBox = "ChatsBox";
  static const String _chatMessageNameBox = "ChatMessageBox";
  static const String _chatMetadataNameBox = "ChatMetadataBox";
  static const int chatHiveAdapterType = 1;
  static const int chatMessageHiveAdapterType = 2;
  static const int chatMetadataHiveAdapterType = 3;
  static const int encrypTypeHiveAdapterType = 4;
  static const int chatMessageTypeHiveAdapterType = 5;
  static const int chatMessageStateHiveAdapterType = 6;
  static const int chatMessageFieldHiveAdapterType = 7;
  static const int chatMessageFieldTypeHiveAdapterType = 8;


  late Box chatBox;
  late Box<ChatMessageHive> chatMessageBox;
  late Box chatMetadataBox;

  List<Map<String,dynamic>> get chatBoxValues => _getValues(chatBox);
  List<Map<String,dynamic>> get chatMessageBoxValues => _getValues(chatMessageBox);
  List<Map<String,dynamic>> get chatMetadataBoxValues => _getValues(chatMetadataBox);

  final PersonUser localPerson = GetIt.I.get<PersonUserRepository>().user;

  init() async{
    await Hive.initFlutter();
    await loadAdapters();
    await loadChatBoxes();
  }

  @visibleForTesting
  initTest() async{
    await loadAdapters();
    await loadChatBoxes();
  }

  Future<void> loadAdapters() async{
    Hive.registerAdapter(ChatHiveAdapter());
    Hive.registerAdapter(ChatMetadataHiveAdapter());
    Hive.registerAdapter(ChatMessageHiveAdapter());
    Hive.registerAdapter(ChatMessageStateAdapter());
    Hive.registerAdapter(ChatMessageTypeAdapter());
    Hive.registerAdapter(EncrypTypeAdapter());
    Hive.registerAdapter(ChatMessageFieldHiveAdapter());
    Hive.registerAdapter(ChatMessageFieldTypeAdapter());
      
  }

  Future<void> loadChatBoxes() async{
    chatBox = await Hive.openBox("${_chatNameBox}_${localPerson.id}");
    chatMessageBox = await Hive.openBox("${_chatMessageNameBox}_${localPerson.id}");
    chatMetadataBox = await Hive.openBox("${_chatMetadataNameBox}_${localPerson.id}");
  }

  Future<void> closeChatBoxes() async{
    await chatBox.close();
    await chatMessageBox.close();
    await chatMetadataBox.close();
  }

  List<Map<String,dynamic>> _getValues(Box box){
    final result = box.toMap().map(
      (k, e) => MapEntry(
        k.toString(),
        Map<String, dynamic>.from(e),
      ),
    );

    return result.values.toList();
  }

  Future<void> saveMessage(ChatMessage chatMessage){
    return chatMessageBox.put(chatMessage.id,chatMessage);
  }

  Future<void> saveChat(Chat chat){
    return chatBox.put(chat.id,chat);
  }

  Future<void> updateChat(Chat chat) {
    return chatBox.put(chat.id,chat);
  }

  Future<void> updateMessage(ChatMessage message) {
    return chatMessageBox.put(message.id,message);
  }

  void deleteMessage(Chat chat,String id) async{
    ChatMessageHive? chatMessage = chatMessageBox.get(id);
    if(chatMessage != null){
      chatMessage.visible = false;
      //await chatMessageBox.delete(chatMessage.id);
      await chatMessageBox.put(chatMessage.id,chatMessage);
    }
    
  }

  Stream<ChatMessage> getStreamMessages(){
    return chatMessageBox.watch().transform<ChatMessage>(chatMessageTransformer);
  }

  Stream<Chat> getStreamChats(){
    return chatBox.watch().transform<Chat>(chatTransformer);
  }

  List<ChatMessage> getChatMessages(Chat chat){
    return chatMessageBox.values.where((event) => event.chatId == chat.id && event.visible == true).map((e) => ChatMessage.fromMap(e.toMap())).toList();
  }

  List<Chat> getChats(){
    return chatBox.values.where((element) => element.enabled!=null && element.enabled).map((e) => Chat.fromMap(e.toMap())).toList();
  }

  StreamTransformer<BoxEvent, ChatMessage> get chatMessageTransformer => 
    StreamTransformer.fromHandlers(handleData: (BoxEvent ev, EventSink<ChatMessage> messages){
      if(!ev.deleted && ev.value.visible){
        messages.add(ChatMessage.fromMap(ev.value.toMap()));
      }
    });
  
  StreamTransformer<BoxEvent, Chat> get chatTransformer => 
    StreamTransformer.fromHandlers(handleData: (BoxEvent ev, EventSink<Chat> chats){
      if(!ev.deleted){
        Chat chat = Chat.fromMap(ev.value.toMap());
        chats.add(chat);
      }
    });

}