import 'package:chatin/module_chat/components_chatroom/chat_send_button.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import './index.dart';

class ChatFoot extends StatefulWidget{
  const ChatFoot({Key? key}) : super(key: key);

  @override
  State<ChatFoot> createState() => _ChatFootState();

}

class _ChatFootState extends State<ChatFoot>{
  BehaviorSubject<bool> onSendCleanEvent = BehaviorSubject<bool>();

  @override
  Widget build(BuildContext context) {
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

}