class ChatWriting{
  static const String collection = "Writing";

  String userId="";
  String chatId;
  DateTime time = DateTime.now().toUtc();
  bool isWriting=false;


  ChatWriting({
    required this.chatId
  });

  factory ChatWriting.basic(String userId, String chatId){
    ChatWriting chatMessage = ChatWriting(
      chatId:chatId,
    );
    chatMessage.userId=userId;
    chatMessage.isWriting=true;
    return chatMessage;
  }

  factory ChatWriting.fromMap(Map<String,dynamic> map){
    ChatWriting chatMessage = ChatWriting(
      chatId:"",
    );
    
    if(map["chatId"]!=null) chatMessage.chatId = map["chatId"];
    if(map["userId"]!=null) chatMessage.userId = map["userId"];
    if(map["isWriting"]!=null) chatMessage.isWriting = map["isWriting"];
    if(map["time"]!=null) chatMessage.time = DateTime.fromMillisecondsSinceEpoch(map["time"],isUtc:true);
 
    return chatMessage;
  }

  Map<String,dynamic> toMap(){

    return {
      "chatId": chatId,
      "userId": userId,
      "isWriting": isWriting,
      "time": time.toUtc().millisecondsSinceEpoch
    };
  }

}