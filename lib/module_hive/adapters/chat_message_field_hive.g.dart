// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_field_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatMessageFieldHiveAdapter extends TypeAdapter<ChatMessageFieldHive> {
  @override
  final int typeId = 7;

  @override
  ChatMessageFieldHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatMessageFieldHive()
      ..id = fields[0] as String
      ..value = fields[1] as String
      ..type = fields[2] as ChatMessageFieldType;
  }

  @override
  void write(BinaryWriter writer, ChatMessageFieldHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessageFieldHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChatMessageFieldTypeAdapter extends TypeAdapter<ChatMessageFieldType> {
  @override
  final int typeId = 8;

  @override
  ChatMessageFieldType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ChatMessageFieldType.none;
      case 1:
        return ChatMessageFieldType.num;
      case 2:
        return ChatMessageFieldType.image;
      case 3:
        return ChatMessageFieldType.audio;
      case 4:
        return ChatMessageFieldType.video;
      case 5:
        return ChatMessageFieldType.text;
      default:
        return ChatMessageFieldType.none;
    }
  }

  @override
  void write(BinaryWriter writer, ChatMessageFieldType obj) {
    switch (obj) {
      case ChatMessageFieldType.none:
        writer.writeByte(0);
        break;
      case ChatMessageFieldType.num:
        writer.writeByte(1);
        break;
      case ChatMessageFieldType.image:
        writer.writeByte(2);
        break;
      case ChatMessageFieldType.audio:
        writer.writeByte(3);
        break;
      case ChatMessageFieldType.video:
        writer.writeByte(4);
        break;
      case ChatMessageFieldType.text:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessageFieldTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
