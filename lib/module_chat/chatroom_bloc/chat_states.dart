import 'package:chatin/module_chat/index.dart';
import 'package:chatin/module_common/models/index.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

@immutable
abstract class ChatState{
  const ChatState([List props = const []]);
}

class ChatInitialState extends ChatState {
  final PersonUser localPerson;
  final PersonUser remotePerson;
  final Chat chat;

  ChatInitialState(this.chat, this.localPerson, this.remotePerson): super([chat, localPerson, remotePerson]);
}

class ChatMessagesLoading extends ChatState {}


class ChatMessagesLoaded extends ChatState {
  final List<ChatMessage> messages;

  ChatMessagesLoaded(this.messages) : super([messages]);
}


class ChatMessagesNotLoaded extends ChatState {}

class ChatMessageSended extends ChatState {}

class ChatMessagesWritingChange extends ChatState {
  final List<ChatWriting> chatWriting;

  ChatMessagesWritingChange(this.chatWriting): super([chatWriting]);
}

class ChatMessagesPersonReloaded extends ChatState {
  final PersonUser person;

  ChatMessagesPersonReloaded(this.person) : super([person]);
}

class ChatSetDateTimeState extends ChatState {
  final DateTime dateTime;

  ChatSetDateTimeState(this.dateTime) : super([dateTime]);
}

class ChatEditMessageState extends ChatState{
  final ChatMessage message;

  ChatEditMessageState(this.message) : super([message]);
}

class ChatSaveMessageState extends ChatState{
  final ChatMessage message;

  ChatSaveMessageState(this.message) : super([message]);
}

class ChatMessagesSelectedState extends ChatState {
  final List<ChatMessage> messages;

  ChatMessagesSelectedState(this.messages) : super([messages]);
}
