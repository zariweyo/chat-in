import 'package:chatin/module_hive/adapters/chat_message_field_hive.dart';
import 'package:chatin/module_hive/adapters/chat_message_hive.dart';
import 'package:uuid/uuid.dart';

class ChatMessage extends ChatMessageHive{
  static const String collection = "Messages";

  String fingerRSA64 = "";
  List<String> cipherData64 = [];


  ChatMessage({
    required chatId,
    required message
  }){
    id=const Uuid().v4();
    this.chatId = chatId;
    this.message = message;
  }

  ChatMessage clone(){
    return ChatMessage.fromMap(toMap());
  }

  iAmOwner(String userId){
    return userId == fromUserId;
  }

  factory ChatMessage.fromMap(Map<String,dynamic> map){
    ChatMessage chatMessage = ChatMessage(
      chatId:"",
      message:"",
    );
    
    if(map["id"]!=null) chatMessage.id = map["id"];
    if(map["chatId"]!=null) chatMessage.chatId = map["chatId"];
    if(map["fromUserId"]!=null) chatMessage.fromUserId = map["fromUserId"];
    if(map["toUserId"]!=null) chatMessage.toUserId = map["toUserId"];
    if(map["message"]!=null) chatMessage.message = map["message"];
    if(map["fingerRSA"]!=null) chatMessage.fingerRSA = map["fingerRSA"];
    if(map["fingerRSA64"]!=null) chatMessage.fingerRSA64 = map["fingerRSA64"];
    if(map["repeatCount"]!=null) chatMessage.repeatCount = map["repeatCount"];
    if(map["time"]!=null) chatMessage.time = DateTime.fromMillisecondsSinceEpoch(map["time"],isUtc:true);
    if(map["state"]!=null) chatMessage.state = ChatMessageState.values.firstWhere((element) => element.toString().split(".")[1] ==map["state"], orElse:() => ChatMessageState.writing)  ;
    if(map["type"]!=null) chatMessage.type = ChatMessageType.values.firstWhere((element) => element.toString().split(".")[1] ==map["type"], orElse:() => ChatMessageType.none)  ;
    if(map["encrypType"]!=null) chatMessage.encrypType = EncrypType.values.firstWhere((element) => element.toString().split(".")[1] ==map["encrypType"], orElse:() => EncrypType.none)  ;
    if(map["cipherData"]!=null) chatMessage.cipherData = (map["cipherData"] as List<dynamic>).map((e)=> e.toString()).toList();
    if(map["cipherData64"]!=null) chatMessage.cipherData64 = (map["cipherData64"] as List<dynamic>).map((e)=> e.toString()).toList();
    if(map["visible"]!=null) chatMessage.visible = map["visible"];
    if(map["fields"]!=null) chatMessage.fields = (map["fields"] as List<dynamic>).map((e)=> ChatMessageFieldHive.fromMap(e)).toList();


    return chatMessage;
  }

  addField(ChatMessageFieldType type){
    fields = fields??[];

    switch(type){
      case ChatMessageFieldType.none:
        break;
      case ChatMessageFieldType.num:
        assert(fields!.where((element) => element.type == ChatMessageFieldType.num).isEmpty);
        fields?.add(ChatMessageFieldHive.newNumField());
        break;
      case ChatMessageFieldType.image:
        break;
      case ChatMessageFieldType.audio:
        break;
      case ChatMessageFieldType.video:
        break;
      case ChatMessageFieldType.text:
        break;
    }
    
  }

  @override
  Map<String,dynamic> toMap({
    ChatMessageState? newState
  }){

    Map<String,dynamic> map = super.toMap(newState:newState);
    map["cipherData"] = cipherData;
    map["cipherData64"] = cipherData64;

    return map;
  }

  Map<String,dynamic> toMapState(){
    return {
      "state": state.toString().split(".")[1],
      "repeatCount": repeatCount+1,
    };
  }
}