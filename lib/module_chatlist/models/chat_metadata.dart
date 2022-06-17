import 'package:chatin/module_hive/adapters/chat_message_hive.dart';
import '../../module_chat/models/chat_message.dart';

class ChatMetadata{

  String id="";
  DateTime lastMessageTime = DateTime.fromMillisecondsSinceEpoch(0).toUtc();
  DateTime lastMessageReadedTimeForMe = DateTime.fromMillisecondsSinceEpoch(0).toUtc();
  int totalMessagesUnreaded = 0;
  String lastMessage = "";
  String lastMessageOwner = "";
  ChatMessageType lastMessageType = ChatMessageType.none;


  ChatMetadata(){
    lastMessageTime = DateTime.fromMillisecondsSinceEpoch(0).toUtc();
  }

  factory ChatMetadata.fromMap(dynamic map){
    ChatMetadata chatMetadata = ChatMetadata();
    
    if(map["id"]!=null) chatMetadata.id = map["id"];
    if(map["totalMessagesUnreaded"]!=null) chatMetadata.totalMessagesUnreaded = map["totalMessagesUnreaded"];
    if(map["lastMessage"]!=null) chatMetadata.lastMessage = map["lastMessage"];
    if(map["lastMessageOwner"]!=null) chatMetadata.lastMessageOwner = map["lastMessageOwner"];
    if(map["lastMessageReadedTimeForMe"]!=null) chatMetadata.lastMessageReadedTimeForMe = DateTime.fromMillisecondsSinceEpoch(map["lastMessageReadedTimeForMe"],isUtc:true);
    if(map["lastMessageTime"]!=null) chatMetadata.lastMessageTime = DateTime.fromMillisecondsSinceEpoch(map["lastMessageTime"],isUtc:true);
    if(map["lastMessageType"]!=null) chatMetadata.lastMessageType = ChatMessageType.values.firstWhere((element) => element.toString().split(".")[1] ==map["lastMessageType"], orElse:() => ChatMessageType.none)  ;


    return chatMetadata;
  }

  lastMessageIsMine(String userId){
    return userId == lastMessageOwner;
  }

  bool itHasChangedToUpdate(){
    return lastMessageTime.compareTo(lastMessageReadedTimeForMe) > 0;
  }

  toMap(){
    var data = {
      "id": id,
      "totalMessagesUnreaded": totalMessagesUnreaded,
      "lastMessageReadedTimeForMe": lastMessageReadedTimeForMe.toUtc().millisecondsSinceEpoch,
      "lastMessageTime": lastMessageTime.toUtc().millisecondsSinceEpoch,
      "lastMessageType": lastMessageType.toString().split(".")[1],
      "lastMessage": lastMessage,
      "lastMessageOwner": lastMessageOwner
    };

    return data;
  }

  updateLastsFromChatMessage(ChatMessage msg){
    lastMessage = msg.message;
    lastMessageTime = msg.time;
    lastMessageType = msg.type;
    lastMessageOwner = msg.fromUserId;
  }
}