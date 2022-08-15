import 'package:chatin/module_hive/adapters/chat_message_field_hive.dart';
import 'package:chatin/module_hive/controllers/hive_controller.dart';
import 'package:hive/hive.dart';

part 'chat_message_hive.g.dart';

@HiveType(typeId : HiveController.chatMessageStateHiveAdapterType)
enum ChatMessageState{
  @HiveField(0)
  writing,

  @HiveField(1)
  sended,

  @HiveField(2)
  received,

  @HiveField(3)
  readed,

  @HiveField(4)
  verified,

  @HiveField(5)
  repeat
}

@HiveType(typeId : HiveController.chatMessageTypeHiveAdapterType)
enum ChatMessageType{
  @HiveField(0)
  none,

  @HiveField(1)
  text
}

@HiveType(typeId : HiveController.encrypTypeHiveAdapterType)
enum EncrypType{
  @HiveField(0)
  none,

  @HiveField(1)
  rsa
}

@HiveType(typeId : HiveController.chatMessageHiveAdapterType)
class ChatMessageHive extends HiveObject{
  @HiveField(0)
  String id = "";

  @HiveField(1)
  String fromUserId = "";

  @HiveField(2)
  String toUserId = "";

  @HiveField(3)
  String chatId = "";

  @HiveField(4)
  String message = "";

  @HiveField(5)
  ChatMessageType type = ChatMessageType.none;

  @HiveField(6)
  ChatMessageState state = ChatMessageState.writing;

  @HiveField(7)
  DateTime time = DateTime.now().toUtc();

  @HiveField(8)
  EncrypType encrypType = EncrypType.none;

  @HiveField(9)
  String fingerRSA = "";

  @HiveField(10)
  int repeatCount = 0;

  @HiveField(11)
  List<String> cipherData = [];

  @HiveField(12)
  bool visible = true;

  @HiveField(13)
  List<ChatMessageFieldHive>? fields = [];


  Map<String,dynamic> toMap({
    ChatMessageState? newState
  }){

    return {
      "id": id,
      "chatId": chatId,
      "fromUserId": fromUserId,
      "toUserId": toUserId,
      "message": message,
      "repeatCount": repeatCount,
      "fingerRSA": fingerRSA,
      "state": newState!=null? newState.toString().split(".")[1] : state.toString().split(".")[1],
      "type": type.toString().split(".")[1],
      "encrypType": encrypType.toString().split(".")[1],
      "time": time.toUtc().millisecondsSinceEpoch,
      "cipherData": cipherData,
      "visible": visible,
      "fields": fields?.map((e) => e.toMap()).toList(),
    };
  }

}