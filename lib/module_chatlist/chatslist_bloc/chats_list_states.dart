import 'package:chatin/module_chat/index.dart';
import 'package:chatin/module_common/models/person_user.dart';
import 'package:chatin/module_chatlist/models/index.dart';

abstract class ChatsListState{
  const ChatsListState([List props = const []]);
}

class ChatsListInitialState extends ChatsListState {}

class ChatsListChatsLoadedState extends ChatsListState {
  final List<Chat> chats;
  final List<ChatMetadata> chatsMetadata;
  final Map<String,PersonUser> persons;

  ChatsListChatsLoadedState(this.chats,this.persons,this.chatsMetadata) : super([chats,persons,chatsMetadata]);
}

class ChatsListEditState extends ChatsListState {
  final Chat chat;
  ChatsListEditState(this.chat) : super([chat]);
}

class ChatsListSaveState extends ChatsListState {
  final Chat chat;
  ChatsListSaveState(this.chat) : super([chat]);
}
