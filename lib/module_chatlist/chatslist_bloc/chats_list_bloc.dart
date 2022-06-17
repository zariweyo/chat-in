import 'dart:async';
import 'package:chatin/module_chat/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chats_list_events.dart';
import 'chats_list_states.dart';



class ChatsListBloc extends Bloc<ChatsListEvent, ChatsListState> {

  late ChatsListController chatsListController;
  StreamSubscription<ReceiveListDataState>? receiveListDataSuscription;

  ChatsListBloc() : super(ChatsListInitialState()){
    chatsListController = ChatsListController();
    on<ChatsListEvent>(mapEventToState);
    receiveListDataSuscription = chatsListController.receiveListDataState.listen(onListData);
    add(ChatsListChatsLoaded(chatsListController.chats,const {}, const[]));
  }

  destroy(){
    chatsListController.destroy();
    receiveListDataSuscription?.cancel();
  }

  Future<void> mapEventToState(ChatsListEvent event, Emitter<ChatsListState> emit) async {
    if(event is ChatsListChatsLoaded) {
      emit(ChatsListChatsLoadedState(event.chats,event.persons,event.chatsMetadata));
    }
    if(event is ChatsListAddEvent) {
      Chat newChat = Chat(name: "NEW");
      chatsListController.saveChat(newChat);
    }
    if(event is ChatsListEditEvent) {
      emit(ChatsListEditState(event.chat));
    }
    if(event is ChatsListSaveEvent) {
      chatsListController.updateChat(event.chat);
      emit(ChatsListSaveState(event.chat));
    }
  }

  void onListData(ReceiveListDataState receiveListDataState){
    if(receiveListDataState==ReceiveListDataState.newChat){
      add(ChatsListChatsLoaded(chatsListController.chats,const {}, const[]));
    }
  }
}