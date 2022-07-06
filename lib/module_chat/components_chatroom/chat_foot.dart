import 'package:chatin/module_chat/chatroom_bloc/index.dart';
import 'package:chatin/module_chat/components_chatroom/chat_send_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';

import './index.dart';

class ChatFoot extends StatefulWidget{
  const ChatFoot({Key? key}) : super(key: key);

  @override
  State<ChatFoot> createState() => _ChatFootState();

}

class _ChatFootState extends State<ChatFoot>{
  bool _isSelectedActive = false;
  BehaviorSubject<bool> onSendCleanEvent = BehaviorSubject<bool>();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChatBloc,ChatState,bool>(
      selector: (state) {
        if(state is ChatMessagesSelectedState) {
          _isSelectedActive = state.messages.isNotEmpty;
        }
        return _isSelectedActive;
      },
      builder: (ctx,isSelected) => 
        isSelected? 
          const ChatSelectedBarActions()
        : 
          Row(
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
          )
    );
  }

}