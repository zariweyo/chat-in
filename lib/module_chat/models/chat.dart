import 'package:chatin/module_hive/adapters/chat_hive.dart';
import 'package:uuid/uuid.dart';

class Chat extends ChatHive{
  static const String collection = "Chats";


  Chat({
    String? name
  }){
    id= const Uuid().v4();
    created = DateTime.now().toUtc();
    lastMessageTime = DateTime.now().toUtc();
    this.name = name?? "NO_NAME";
  }

  factory Chat.newChat(List<String> users){
    Chat chat = Chat();
    chat.users = users;
    chat.generateId();
    return chat;
  }

  factory Chat.fromMap(dynamic map){
    Chat chat = Chat();
    
    if(map["id"]!=null) chat.id = map["id"];
    if(map["totalMessages"]!=null) chat.totalMessages = map["totalMessages"];
    if(map["totalAcumulativeMessages"]!=null) chat.totalAcumulativeMessages = map["totalAcumulativeMessages"];
    if(map["lastUserId"]!=null) chat.lastUserId = map["lastUserId"];
    if(map["name"]!=null) chat.name = map["name"];
    if(map["enabled"]!=null) chat.enabled = map["enabled"];
    if(map["users"]!=null) chat.users = (map["users"] as List<dynamic>).map((e)=> e.toString()).toList();
    if(map["created"]!=null) chat.created = DateTime.fromMillisecondsSinceEpoch(map["created"],isUtc:true);
    if(map["lastMessageTime"]!=null) chat.lastMessageTime = DateTime.fromMillisecondsSinceEpoch(map["lastMessageTime"],isUtc:true);

    return chat;
  }

  generateId(){
    String idSeed = "";

    users.sort((String a, String b){
      return a.compareTo(b);
    });
    
    for (var element in users) {
      idSeed += "$element:";
    }
    
    if(idSeed==""){
      return;
    }

    id = const Uuid().v5(Uuid.NAMESPACE_URL, idSeed);
  }
}