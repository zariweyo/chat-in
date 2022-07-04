import 'package:chatin/module_chat/index.dart';
import 'package:chatin/module_common/models/index.dart';
import 'package:chatin/module_hive/adapters/chat_message_hive.dart';
import 'package:chatin/module_hive/index.dart';
import 'package:chatin/repositories/personuser_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

enum ReceiveDataState {
  none,
  newMessage
}

class ChatRoomController{

  final List<ChatMessage> _messages = [];
  Chat chat;
  bool isWriting=false;
  final PersonUser localPerson = GetIt.I.get<PersonUserRepository>().user;
  final HiveController hiveController = GetIt.I.get<HiveController>();
  final PersonUser remotePerson;

  List<ChatMessage> get messages => _messages..sort((a,b) => b.time.compareTo(a.time));
  BehaviorSubject<ReceiveDataState> receiveDataState = BehaviorSubject<ReceiveDataState>();

  ChatRoomController({
    required this.chat,
    required this.remotePerson
  }){
    hiveController.getStreamMessages().listen(onMessageReceived);
    _messages.addAll(hiveController.getChatMessages(chat));
  }

  sendMessage(String message){
    ChatMessage newMessage = ChatMessage(chatId: chat.id, message: message);
    newMessage.type = ChatMessageType.text;
    newMessage.fromUserId = localPerson.id;
    newMessage.toUserId = remotePerson.id;
    newMessage.chatId = chat.id;

    hiveController.saveMessage(newMessage);
  }

  deleteMessage(String id){
    _messages.removeWhere((element) => element.id==id);
    hiveController.deleteMessage(chat,id);
  }


  ValueStream<ReceiveDataState> get onReceiveDataState => receiveDataState.stream;

  onMessageReceived(ChatMessage message){
    _messages.add(message);
    receiveDataState.add(ReceiveDataState.newMessage);
  }

  destroy(){
  }
}