// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatMessageHiveAdapter extends TypeAdapter<ChatMessageHive> {
  @override
  final int typeId = 2;

  @override
  ChatMessageHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatMessageHive()
      ..id = fields[0] as String
      ..fromUserId = fields[1] as String
      ..toUserId = fields[2] as String
      ..chatId = fields[3] as String
      ..message = fields[4] as String
      ..type = fields[5] as ChatMessageType
      ..state = fields[6] as ChatMessageState
      ..time = fields[7] as DateTime
      ..encrypType = fields[8] as EncrypType
      ..fingerRSA = fields[9] as String
      ..repeatCount = fields[10] as int
      ..cipherData = (fields[11] as List).cast<String>()
      ..visible = fields[12] as bool
      ..fields = (fields[13] as List?)?.cast<ChatMessageFieldHive>();
  }

  @override
  void write(BinaryWriter writer, ChatMessageHive obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fromUserId)
      ..writeByte(2)
      ..write(obj.toUserId)
      ..writeByte(3)
      ..write(obj.chatId)
      ..writeByte(4)
      ..write(obj.message)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.state)
      ..writeByte(7)
      ..write(obj.time)
      ..writeByte(8)
      ..write(obj.encrypType)
      ..writeByte(9)
      ..write(obj.fingerRSA)
      ..writeByte(10)
      ..write(obj.repeatCount)
      ..writeByte(11)
      ..write(obj.cipherData)
      ..writeByte(12)
      ..write(obj.visible)
      ..writeByte(13)
      ..write(obj.fields);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessageHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChatMessageStateAdapter extends TypeAdapter<ChatMessageState> {
  @override
  final int typeId = 6;

  @override
  ChatMessageState read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ChatMessageState.writing;
      case 1:
        return ChatMessageState.sended;
      case 2:
        return ChatMessageState.received;
      case 3:
        return ChatMessageState.readed;
      case 4:
        return ChatMessageState.verified;
      case 5:
        return ChatMessageState.repeat;
      default:
        return ChatMessageState.writing;
    }
  }

  @override
  void write(BinaryWriter writer, ChatMessageState obj) {
    switch (obj) {
      case ChatMessageState.writing:
        writer.writeByte(0);
        break;
      case ChatMessageState.sended:
        writer.writeByte(1);
        break;
      case ChatMessageState.received:
        writer.writeByte(2);
        break;
      case ChatMessageState.readed:
        writer.writeByte(3);
        break;
      case ChatMessageState.verified:
        writer.writeByte(4);
        break;
      case ChatMessageState.repeat:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessageStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChatMessageTypeAdapter extends TypeAdapter<ChatMessageType> {
  @override
  final int typeId = 5;

  @override
  ChatMessageType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ChatMessageType.none;
      case 1:
        return ChatMessageType.text;
      default:
        return ChatMessageType.none;
    }
  }

  @override
  void write(BinaryWriter writer, ChatMessageType obj) {
    switch (obj) {
      case ChatMessageType.none:
        writer.writeByte(0);
        break;
      case ChatMessageType.text:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessageTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EncrypTypeAdapter extends TypeAdapter<EncrypType> {
  @override
  final int typeId = 4;

  @override
  EncrypType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EncrypType.none;
      case 1:
        return EncrypType.rsa;
      default:
        return EncrypType.none;
    }
  }

  @override
  void write(BinaryWriter writer, EncrypType obj) {
    switch (obj) {
      case EncrypType.none:
        writer.writeByte(0);
        break;
      case EncrypType.rsa:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EncrypTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
