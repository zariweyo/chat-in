import 'dart:async';
import 'package:chatin/module_chat/models/index.dart';
import 'package:chatin/module_common/models/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'index.dart';



class ChatBloc extends Bloc<ChatEvent, ChatState> {
  late ChatRoomController chatRoomController;
  late String message="";
  StreamSubscription<ReceiveDataState>? onReceiveDataSuscription;

  ChatBloc(Chat chat, PersonUser localPerson, PersonUser remotePerson) : super(ChatInitialState(localPerson, remotePerson)){
    chatRoomController = ChatRoomController(
      chat: chat,
      remotePerson: remotePerson);
    on<ChatEvent>(mapEventToState);
    onReceiveDataSuscription = chatRoomController.onReceiveDataState.listen(onReceiveData);
    add(ChatUpdateMessages(chatRoomController.messages));
  }
  

  destroy(){
    chatRoomController.destroy();
    onReceiveDataSuscription?.cancel();
  }

  Future<void> mapEventToState(ChatEvent event, Emitter<ChatState> emit) async {
    if (event is ChatSendMessage) {
      if(message.isNotEmpty){
        chatRoomController.sendMessage(message);
        message="";
        emit(ChatMessageSended());
      }
    }else if (event is ChatIWritingMessage) {
      //yield* _mapSetWriting(event.isWriting);
    }else if (event is ChatSetMessage) {
      message=event.message;
    }else if (event is ChatUpdateMessages) {
      emit(ChatMessagesLoaded(chatRoomController.messages));
    }else if (event is ChatInitialMessagesEvent) {
      emit(ChatMessagesLoaded(chatRoomController.messages));
    }else if (event is ChatSomeboyIsWritingMessage) {
      //yield ChatMessagesWritingChange([event.chatWriting]);
    }else if (event is ChatMessagesPersonReloadEvent) {
      //yield ChatMessagesPersonReloaded(event.person);
    }else if (event is ChatSetDateTimeEvent) {
      emit(ChatSetDateTimeState(event.dateTime));
    }else if (event is ChatMessageDeleteEvent) {
      chatRoomController.deleteMessage(event.messageId);
    }
  }

  void onReceiveData(ReceiveDataState receiveDataState){
    if(receiveDataState==ReceiveDataState.newMessage){
      add(ChatUpdateMessages(chatRoomController.messages));
    }
  }
}