import 'dart:async';
import 'package:chatin/module_chat/index.dart';
import 'package:chatin/module_common/models/index.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  late ChatRoomController chatRoomController;
  late String message="";
  ChatMessage? currentChatMessage;
  StreamSubscription<ReceiveDataState>? onReceiveDataSuscription;

  ChatBloc(Chat chat, PersonUser localPerson, PersonUser remotePerson) : super(ChatInitialState(chat, localPerson, remotePerson)){
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
    }else if (event is ChatSetMessage) {
      message=event.message;
    }else if (event is ChatUpdateMessages) {
      emit(ChatMessagesLoaded(chatRoomController.messages));
    }else if (event is ChatInitialMessagesEvent) {
      emit(ChatMessagesLoaded(chatRoomController.messages));
    }else if (event is ChatSetDateTimeEvent) {
      emit(ChatSetDateTimeState(event.dateTime));
    }else if (event is ChatMessageDeleteEvent) {
      chatRoomController.deleteMessage(event.messageId);
    }else if (event is ChatEditMessageEvent) {
      currentChatMessage = event.message;
      editChatMessage(emit);
    }else if (event is ChatSaveMessageEvent) {
      chatRoomController.updateMessage(event.message);
      emit(ChatSaveMessageState(event.message));
      emit(ChatBarState(ChatBarType.none));
    }else if (event is ChatMessageSelectedEvent) {
      List<ChatMessage> messageIds = chatRoomController.messageSelected(event.message);
      emit(ChatMessagesSelectedState(messageIds));
      if(messageIds.isEmpty){
        emit(ChatBarState(ChatBarType.none));
      }else{
        emit(ChatBarState(ChatBarType.selectedBar));
      }
      
    }else if (event is ChatMessagesSelectedActionEvent) {
      if(event.action == ChatBarActionType.clean){
        chatRoomController.clearMessagesSelected();
        emit(ChatMessagesSelectedState(const []));
        emit(ChatBarState(ChatBarType.none));
      }else if(event.action == ChatBarActionType.share){
        Share.share(chatRoomController.selectedMessages.map((msg) => msg.message).join("\n"));
        chatRoomController.clearMessagesSelected();
        emit(ChatMessagesSelectedState(const []));  
        emit(ChatBarState(ChatBarType.none));
      }else if(event.action == ChatBarActionType.copy){
        Clipboard.setData(ClipboardData(text: chatRoomController.selectedMessages.map((msg) => msg.message).join("\n")));
        chatRoomController.clearMessagesSelected();
        emit(ChatMessagesSelectedState(const []));
        emit(ChatBarState(ChatBarType.none));
      }else if(event.action == ChatBarActionType.edit){
        if(chatRoomController.selectedMessages.isNotEmpty){
          currentChatMessage = chatRoomController.selectedMessages.first;
          editChatMessage(emit);
        }
      }
    }else if (event is ChatMessagesEditingActionEvent) {
      if(event.action == ChatBarEditActionType.save){
        emit(ChatMessagesEditingActionState(event.action));
      }else if(event.action == ChatBarEditActionType.newNumField){
        emit(ChatMessagesEditingActionState(event.action));
      }
    }
  }

  void editChatMessage(Function(ChatState) emit){
    if(currentChatMessage != null){
      emit(ChatEditMessageState(currentChatMessage!));
      chatRoomController.clearMessagesSelected();
      emit(ChatMessagesSelectedState(const []));
      emit(ChatBarState(ChatBarType.editingBar));
    }
  }

  void onReceiveData(ReceiveDataState receiveDataState){
    if(receiveDataState==ReceiveDataState.newMessage){
      add(ChatUpdateMessages(chatRoomController.messages));
    }
  }
}