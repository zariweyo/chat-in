// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatHiveAdapter extends TypeAdapter<ChatHive> {
  @override
  final int typeId = 1;

  @override
  ChatHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatHive()
      ..id = fields[0] as String
      ..users = (fields[1] as List).cast<String>()
      ..created = fields[2] as DateTime
      ..lastMessageTime = fields[3] as DateTime
      ..totalMessages = fields[4] as int
      ..totalAcumulativeMessages = fields[5] as int
      ..lastUserId = fields[6] as String
      ..name = fields[7] as String;
  }

  @override
  void write(BinaryWriter writer, ChatHive obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.users)
      ..writeByte(2)
      ..write(obj.created)
      ..writeByte(3)
      ..write(obj.lastMessageTime)
      ..writeByte(4)
      ..write(obj.totalMessages)
      ..writeByte(5)
      ..write(obj.totalAcumulativeMessages)
      ..writeByte(6)
      ..write(obj.lastUserId)
      ..writeByte(7)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
