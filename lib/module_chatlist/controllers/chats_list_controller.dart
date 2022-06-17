import 'dart:async';

import 'package:chatin/module_chat/index.dart';
import 'package:chatin/module_hive/controllers/hive_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

enum ReceiveListDataState {
  none,
  newChat,
  updateChat,
  chatsLoaded
}

class ChatsListController{
  final List<Chat> _chats = [];
  StreamSubscription? streamHiveChat;

  final HiveController hiveController = GetIt.I.get<HiveController>();
  BehaviorSubject<ReceiveListDataState> receiveListDataState = BehaviorSubject<ReceiveListDataState>();

  List<Chat> get chats => _chats..sort((a,b) => b.lastMessageTime.compareTo(a.lastMessageTime));

  ChatsListController(){
    loadChats();
    suscribeHive();
    hiveController.getStreamChats().listen(onListDataReceived);
  }

  onListDataReceived(Chat chat){
    int index = _chats.indexWhere((element) => element.id==chat.id);
    if(index<0){
      _chats.add(chat);
      receiveListDataState.add(ReceiveListDataState.newChat);
    }else{
      _chats[index] = chat;
      receiveListDataState.add(ReceiveListDataState.updateChat);
    }
  }

  destroy() async {
    if(streamHiveChat!=null) await streamHiveChat!.cancel();
  }


  Future<void> saveChat(Chat newChat){
    return hiveController.saveChat(newChat);
  }

  Future<void> updateChat(Chat chat){
    return hiveController.updateChat(chat);
  }

  loadChats() async{
    List<Chat> chats = hiveController.getChats();
    _chats.addAll(chats);
    receiveListDataState.add(ReceiveListDataState.chatsLoaded);
  }

  suscribeHive(){
    if(streamHiveChat!=null){
      return;
    }

    streamHiveChat = hiveController.chatMetadataBox.watch().listen((event) {
      loadChats();
    });
  }

}