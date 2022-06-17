/* import 'package:chatin/module_chat/index.dart';
import 'package:chatin/module_common/library/rsa_helper.dart';
import 'package:chatin/module_common/models/PersonUser.dart';
import 'package:chatin/module_hive/controllers/HiveController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageController{

  static Future<void> returnFBMessageAsReaded(ChatMessage _msg) async {
    if(_msg.state==ChatMessageState.SENDED && !_msg.iAmOwner()){
      _msg.state=ChatMessageState.READED;
      HiveController.instance!.chatMessageBox.put(_msg.id, _msg.toMap());
      return returnFBMessageStateUpdated(_msg);
    }

    return;
  } 

  static Future<void> returnFBMessageStateUpdated(ChatMessage _msg) async {
      try{
        await FirebaseFirestore.instance
          .collection(Chat.COLLECTION)
          .doc(_msg.chatId)
          .collection(ChatMessage.COLLECTION)
          .doc(_msg.id)
          .update(_msg.toMapState());
        return;
      }catch(e){
        //print(e);
      }

    return;
  }

  static Map<String,PersonUser> personsCache(){
    return const {};
  }

  // We need send FB message encrypted, if we can
  static Future<ChatMessage?> sendFBMessage(Chat _chat, ChatMessage chatMessage,{Function(void) onEnd}) async {

    ChatMessage _newMessage = chatMessage.clone();

    String otherId = getOtherId(_chat.users, _newMessage.userId);
    if(otherId != "" && personsCache()[otherId]!=null){
      PersonUser? other = personsCache()[otherId];
      if(other!=null && other.pubKey!=""){
        RSAHelper rsaHelper = RSAHelper();
        _newMessage = rsaHelper.encryptRSA(_newMessage, other.pubKey??="");
      }
    }

    try{
      await FirebaseFirestore.instance
        .collection(Chat.COLLECTION)
        .doc(_newMessage.chatId)
        .collection(ChatMessage.COLLECTION)
        .doc(_newMessage.id)
        .set(_newMessage.toMap(newState: ChatMessageState.SENDED))
        .then(onEnd);
      
      return _newMessage;
    }catch(e){
      return null;
    }
  }

  static String getOtherId(List<String> _users,String _owner){
    return _users.firstWhere((element) => element!=_owner, orElse: () => "");
  }

  static Future<void> deleteFBMessage(ChatMessage _msg) async{
    if(_msg.state==ChatMessageState.READED && _msg.iAmOwner()){
      try {
        await FirebaseFirestore.instance
          .collection(Chat.COLLECTION)
          .doc(_msg.chatId)
          .collection(ChatMessage.COLLECTION).doc(_msg.id).delete();
      }catch(e){
        print(e);
      }
    }

    return;
  }

  // Need to decrypt message if is encrypted. Only have one posibility
  static Future<void> readMessages(Chat chat, RSAHelper rsaHelper, RSAHelperModel rsaData) async{

    //RSAHelperModel _fakeRSA = await rsaHelper.generateRSAPairs();
    
    await FirebaseFirestore.instance
      .collection(Chat.COLLECTION)
      .doc(chat.id)
      .collection(ChatMessage.COLLECTION).get().then((_qSnap) async {
        Map<String,Map<String,dynamic>> _changes = {};
        ChatMetadata _lastMetadata = new ChatMetadata();
        _lastMetadata.id=chat.id;
        dynamic _metadataBoxValue = HiveController.instance!.chatMetadataBox.get(chat.id);
        if(_metadataBoxValue!=null){
          _lastMetadata = ChatMetadata.fromMap(_metadataBoxValue);
        }
        
        for(QueryDocumentSnapshot element in _qSnap.docs){          

          ChatMessage chatMessage = ChatMessage.fromMap(element.data() as Map<String,dynamic>);

          if(chatMessage.userId==UserController.instance.user.id && chatMessage.state==ChatMessageState.REPEAT){

            Map<dynamic, dynamic>? mapData = HiveController.instance!.chatMessageBox.get(chatMessage.id);
            if(mapData==null){
              //HiveController.instance.chatMessageBox.add(value)
              chatMessage.state=ChatMessageState.READED;
              sendFBMessage(chat,chatMessage);
              return;
            }
            ChatMessage chatMessageSearch = ChatMessage.fromMap(
              Map<String, dynamic>.from(mapData));
            
            List<PersonUser> _persons = await PlayersProvider.getPlayersByList(chat.users);
            _persons.forEach((element) {
                Globals.cachePersons[element.id] = element;
            });
            chatMessageSearch.state=ChatMessageState.SENDED;
            if(chatMessageSearch.repeatCount>=5){
              chatMessageSearch.state=ChatMessageState.READED;
            }
            sendFBMessage(chat,chatMessageSearch);
            
          }else if(chatMessage.userId!=UserController.instance.user.id && chatMessage.encrypType==EncrypType.RSA){
            ChatMessage chatMessageDecrypted = rsaHelper.decryptRSA(chatMessage, rsaData.private);
            if(chatMessageDecrypted==null){
              if(chatMessage.repeatCount<=2 && chatMessage.state==ChatMessageState.SENDED){
                chatMessage.state=ChatMessageState.REPEAT;
                ChatMessageController.returnFBMessageStateUpdated(chatMessage);
              }
            }else{
              _changes[chatMessageDecrypted.id] = chatMessageDecrypted.toMap();
              if(chatMessageDecrypted.time.compareTo(_lastMetadata.lastMessageTime)>0){
                _lastMetadata.updateLastsFromChatMessage(chatMessageDecrypted);
              }
            }
          }else if(chatMessage.userId!=UserController.instance.user.id && chatMessage.encrypType==EncrypType.NONE){
            _changes[chatMessage.id] = chatMessage.toMap();
            if(chatMessage.time.compareTo(_lastMetadata.lastMessageTime)>0){
              _lastMetadata.updateLastsFromChatMessage(chatMessage);
            }
          }else if(chatMessage.userId==UserController.instance.user.id && HiveController.instance.chatMessageBox.get(chatMessage.id)!=null){
            ChatMessage chatMessageReveived = ChatMessage.fromMap(Map<String, dynamic>.from(HiveController.instance.chatMessageBox.get(chatMessage.id)));
            chatMessage.message = chatMessageReveived.message;
            chatMessage.encrypType = chatMessageReveived.encrypType;
            _changes[chatMessage.id] = chatMessage.toMap();
            if(chatMessage.time.compareTo(_lastMetadata.lastMessageTime)>0){
              _lastMetadata.updateLastsFromChatMessage(chatMessage);
            }
          }

        }

        if(_lastMetadata.itHasChangedToUpdate()!=Globals.messagesPendingChange.valueWrapper.value){
          Globals.messagesPendingChange.add(_lastMetadata.itHasChangedToUpdate());
        }
        
        await HiveController.instance!.chatMetadataBox.put(_lastMetadata.id,_lastMetadata.toMap());
        await HiveController.instance!.chatMessageBox.putAll(_changes);

      })
      .onError((FirebaseException error, stackTrace){
        //print("${error.message!} ==> $stackTrace");
      });
  }


} */