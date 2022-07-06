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
  final List<ChatMessage> _selectedMessages = [];
  Chat chat;
  bool isWriting=false;
  final PersonUser localPerson = GetIt.I.get<PersonUserRepository>().user;
  final HiveController hiveController = GetIt.I.get<HiveController>();
  final PersonUser remotePerson;

  List<ChatMessage> get messages => _messages..sort((a,b) => b.time.compareTo(a.time));
  List<ChatMessage> get selectedMessages => _selectedMessages..sort((a,b) => a.time.compareTo(b.time));
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

  updateMessage(ChatMessage message){
    hiveController.updateMessage(message);
  }

  List<ChatMessage> messageSelected(ChatMessage message){
    if(_selectedMessages.contains(message)){
      _selectedMessages.removeWhere((element) => element.id==message.id);
    }else{
      _selectedMessages.add(message);
    }
    return _selectedMessages;
  }

  clearMessagesSelected(){
    _selectedMessages.clear();
  }

  ValueStream<ReceiveDataState> get onReceiveDataState => receiveDataState.stream;

  onMessageReceived(ChatMessage message){
    
    int index = _messages.indexWhere((element) => element.id==message.id);
    if(index<0){
      _messages.add(message);
      receiveDataState.add(ReceiveDataState.newMessage);
    }else{
      _messages[index] = message;
      //receiveDataState.add(ReceiveDataState.updateMessage);
    }
  }

  destroy(){
  }
}