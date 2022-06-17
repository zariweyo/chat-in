import 'package:chatin/module_chat/index.dart';
import 'package:chatin/module_common/models/index.dart';

abstract class ChatEvent {
  const ChatEvent([List props = const []]);
}

class ChatInitialMessagesEvent extends ChatEvent {}

class ChatSendMessage extends ChatEvent {
  ChatSendMessage() : super([]);
}

class ChatUpdateMessages extends ChatEvent {
  final List<ChatMessage> messages;

  ChatUpdateMessages(this.messages) : super([messages]);
}

class ChatIWritingMessage extends ChatEvent {
  final bool isWriting;

  ChatIWritingMessage(this.isWriting) : super([isWriting]);
}

class ChatSetMessage extends ChatEvent {
  final String message;

  ChatSetMessage(this.message) : super([message]);
}

class ChatSomeboyIsWritingMessage extends ChatEvent {
  final ChatWriting chatWriting;

  ChatSomeboyIsWritingMessage(this.chatWriting) : super([chatWriting]);
}

class ChatMessagesPersonReloadEvent extends ChatEvent {
  final PersonUser person;

  ChatMessagesPersonReloadEvent(this.person) : super([person]);
}

class ChatMessageDeleteEvent extends ChatEvent {
  final String messageId;

  ChatMessageDeleteEvent(this.messageId) : super([messageId]);
}


class ChatSetDateTimeEvent extends ChatEvent {
  final DateTime dateTime;

  ChatSetDateTimeEvent(this.dateTime) : super([dateTime]);
}