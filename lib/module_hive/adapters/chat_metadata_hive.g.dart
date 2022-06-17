// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_metadata_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatMetadataHiveAdapter extends TypeAdapter<ChatMetadataHive> {
  @override
  final int typeId = 3;

  @override
  ChatMetadataHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatMetadataHive()
      ..id = fields[0] as String
      ..totalMessagesUnreaded = fields[1] as int
      ..lastMessageTime = fields[2] as int
      ..lastMessageReadedTimeForMe = fields[3] as int
      ..lastMessageType = fields[4] as String
      ..lastMessage = fields[5] as String
      ..lastMessageOwner = fields[6] as String;
  }

  @override
  void write(BinaryWriter writer, ChatMetadataHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.totalMessagesUnreaded)
      ..writeByte(2)
      ..write(obj.lastMessageTime)
      ..writeByte(3)
      ..write(obj.lastMessageReadedTimeForMe)
      ..writeByte(4)
      ..write(obj.lastMessageType)
      ..writeByte(5)
      ..write(obj.lastMessage)
      ..writeByte(6)
      ..write(obj.lastMessageOwner);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMetadataHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
