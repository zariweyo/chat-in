import 'package:chatin/module_chat/index.dart';
import 'package:chatin/module_common/models/index.dart';
import 'package:chatin/module_chatlist/models/index.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ChatsListEvent {
  const ChatsListEvent([List props = const []]);
}

class ChatsListInitialEvent extends ChatsListEvent {}

class ChatsListAddEvent extends ChatsListEvent {}

class ChatsListEditEvent extends ChatsListEvent {
  final Chat chat;
  ChatsListEditEvent(this.chat) : super([chat]);
}

class ChatsListSaveEvent extends ChatsListEvent {
  final Chat chat;
  ChatsListSaveEvent(this.chat) : super([chat]);
}

class ChatsListDeleteEvent extends ChatsListEvent {
  final Chat chat;
  ChatsListDeleteEvent(this.chat) : super([chat]);
}

class ChatsListModalChatEvent extends ChatsListEvent {
  final BuildContext context;
  final Chat chat;
  ChatsListModalChatEvent(this.context, this.chat) : super([context, chat]);
}

class ChatsListSetUsers extends ChatsListEvent {
  final List<String> users;

  ChatsListSetUsers(this.users) : super([users]);
}

class ChatsListChatsLoaded extends ChatsListEvent {
  final List<Chat> chats;
  final List<ChatMetadata> chatsMetadata;
  final Map<String,PersonUser> persons;

  ChatsListChatsLoaded(this.chats,this.persons,this.chatsMetadata) : super([chats,persons,chatsMetadata]);
}


