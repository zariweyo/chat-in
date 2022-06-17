import 'package:chatin/module_chat/components_chatroom/chat_messages_list.dart';
import 'package:flutter/material.dart';
import 'chat_message_advice.dart';
import 'chat_messages_writting.dart';

class ChatMessages extends StatefulWidget{
  const ChatMessages({Key? key}) : super(key: key);

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages>{

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(2),
        child: Column(
          children: const [
            ChatMessageAdvice(),
            Expanded(
              child: ChatMessagesList()
            ),
            ChatMessagesWritting()
          ]
        )
    );
  }

}