import 'package:chatin/module_hive/controllers/hive_controller.dart';
import 'package:hive/hive.dart';

part 'chat_metadata_hive.g.dart';

@HiveType(typeId : HiveController.chatMetadataHiveAdapterType)
class ChatMetadataHive extends HiveObject{
  @HiveField(0)
  late String id;

  @HiveField(1)
  late int totalMessagesUnreaded;

  @HiveField(2)
  late int lastMessageTime;

  @HiveField(3)
  late int lastMessageReadedTimeForMe;

  @HiveField(4)
  late String lastMessageType;

  @HiveField(5)
  late String lastMessage;

  @HiveField(6)
  late String lastMessageOwner;

}