import 'package:chatin/module_hive/controllers/hive_controller.dart';
import 'package:hive/hive.dart';

part 'chat_hive.g.dart';

@HiveType(typeId : HiveController.chatHiveAdapterType)
class ChatHive extends HiveObject{
  @HiveField(0)
  String id = "";

  @HiveField(1)
  List<String> users = const [];

  @HiveField(2)
  DateTime created = DateTime.now().toUtc();

  @HiveField(3)
  DateTime lastMessageTime = DateTime.now().toUtc();

  @HiveField(4)
  int totalMessages = 0;

  @HiveField(5)
  int totalAcumulativeMessages = 0;

  @HiveField(6)
  String lastUserId = "";

  @HiveField(7)
  String name = "";

  toMap(){
    var data = {
      "id": id,
      "users": users,
      "name": name,
      "totalMessages": totalMessages,
      "totalAcumulativeMessages": totalAcumulativeMessages,
      "lastUserId": lastUserId,
      "created": created.toUtc().millisecondsSinceEpoch,
      "lastMessageTime": lastMessageTime.toUtc().millisecondsSinceEpoch
    };

    return data;
  }
}