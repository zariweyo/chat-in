/* import 'dart:async';

import 'package:chatin/module_chat/index.dart';
import 'package:chatin/module_chat/models/ChatMetadata.dart';
import 'package:chatin/module_common/library/rsa_helper.dart';
import 'package:chatin/module_hive/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatController{

  StreamSubscription? streamFBChat;
  String _currentUser="";
  late RSAHelper rsaHelper;
  late RSAHelperModel rsaData;

  init(){
    UserController.instance.getUserStateChangeStream().listen(_userStateChange);
  }

  _userStateChange(_isLogged) async {
    if(UserController.instance.isLoginTrue()){
      if(_currentUser!=UserController.instance.user.id){
        await _destroy();
        _currentUser = UserController.instance.user.id;
      }

      await HiveController.instance!.loadChatBoxes(UserController.instance.user.id);

      await _loadRSA();

      suscribeFB();
    }else{
      await _destroy();
      await HiveController.instance!.closeChatBoxes();
    }
  }

  Future<void> _destroy() async{
    if(streamFBChat!=null){
      await streamFBChat!.cancel(); 
      streamFBChat=null;
    }
    return;
  }

  _loadRSA() async{
    rsaHelper = RSAHelper();
    rsaData = await rsaHelper.getLocalRSAPairs();
  }

  suscribeFB(){
    if(streamFBChat!=null){
      return;
    }
    try{
      streamFBChat = FirebaseFirestore.instance
        .collection(Chat.COLLECTION)
        .where("users",arrayContains: UserController.instance.user.id)
        .snapshots().listen((event) async {
          Map<String,Map<String,dynamic>> _changes = {};

          for(DocumentChange _docChange in event.docChanges){
            if(_docChange.type==DocumentChangeType.removed){
              return;
            }

            Chat chat = Chat.fromMap(_docChange.doc.data());

            _changes[chat.id] = chat.toMap();

            if(chat.totalMessages>0){
              await ChatMessageController.readMessages(chat,rsaHelper,rsaData);
            }
          }
          
          await HiveController.instance!.chatBox.putAll(_changes);

        });
    }catch(err){
      print(err);
    }
  }

  static ChatMetadata? getLastMessageForNotification(String chatId){
    dynamic chatMetaMap = HiveController.instance!.chatMetadataBox.get(chatId);
    if(chatMetaMap!=null){
        ChatMetadata chatMetadata = ChatMetadata.fromMap(chatMetaMap);
        return chatMetadata;
    }

    return null;

  }

  
} */