import 'package:chatin/module_chat/chatroom_bloc/index.dart';
import 'package:chatin/module_chat/components_chatroom/chat_send_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';

import './index.dart';

enum ChatBarType {
  none,
  selectedBar,
  editingBar
}

class ChatFoot extends StatefulWidget{
  const ChatFoot({Key? key}) : super(key: key);

  @override
  State<ChatFoot> createState() => _ChatFootState();

}

class _ChatFootState extends State<ChatFoot>{
  ChatBarType chatBarType = ChatBarType.none;
  BehaviorSubject<bool> onSendCleanEvent = BehaviorSubject<bool>();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChatBloc,ChatState,ChatBarType>(
      selector: (state) {
        if(state is ChatBarState) {
          chatBarType = state.type;
        }
        
        return chatBarType;
      },
      builder: (ctx,chatBarTypeSelected) {
        switch(chatBarTypeSelected){
          case ChatBarType.selectedBar:
            return const ChatBarActionsSelected();
          case ChatBarType.editingBar:
            return const ChatBarActionsEditing();
          case ChatBarType.none:
          default:
            return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children:[
              Expanded(
                child: ChatTextField(
                  cleanListener: onSendCleanEvent.stream
                )
              ),
              ChatSendButton(
                onSend: (ev){
                  onSendCleanEvent.add(ev);
                }
              )
            ]
          );
        }
    });
  }

}