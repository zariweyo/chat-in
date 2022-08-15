import 'package:chatin/module_hive/controllers/hive_controller.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'chat_message_field_hive.g.dart';


@HiveType(typeId : HiveController.chatMessageFieldTypeHiveAdapterType)
enum ChatMessageFieldType{
  @HiveField(0)
  none,

  @HiveField(1)
  num,

  @HiveField(2)
  image,

  @HiveField(3)
  audio,

  @HiveField(4)
  video,

  @HiveField(5)
  text
}

@HiveType(typeId : HiveController.chatMessageFieldHiveAdapterType)
class ChatMessageFieldHive extends HiveObject{
  @HiveField(0)
  String id = "";

  @HiveField(1)
  String value = "";

  @HiveField(2)
  ChatMessageFieldType type = ChatMessageFieldType.none;

  ChatMessageFieldHive();

  factory ChatMessageFieldHive.fromMap(dynamic map){
    ChatMessageFieldHive chatMessageField = ChatMessageFieldHive();
    
    if(map["id"]!=null) chatMessageField.id = map["id"];
    if(map["value"]!=null) chatMessageField.value = map["value"];
    if(map["type"]!=null) chatMessageField.type = ChatMessageFieldType.values.firstWhere((element) => element.toString().split(".")[1] ==map["type"], orElse:() => ChatMessageFieldType.none);

    return chatMessageField;
  }

  factory ChatMessageFieldHive.newNumField(){
    ChatMessageFieldHive chatMessageField = ChatMessageFieldHive(); 
    chatMessageField.id= const Uuid().v4();
    chatMessageField.value= "0";
    chatMessageField.type= ChatMessageFieldType.num;

    return chatMessageField;
  }

  Map<String,dynamic> toMap(){
    return {
      "id": id,
      "value": value,
      "type": type.toString().split(".")[1]
    };
  }

}