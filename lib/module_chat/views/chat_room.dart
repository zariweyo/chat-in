import 'package:chatin/module_chat/components_chatroom/chat_sub_header.dart';
import 'package:chatin/module_common/index.dart';
import 'package:chatin/module_chat/index.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget{
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        elevation: 0,
        actions: const [],
        title: const ChatHeader(),
        leading: const MBack(
          color: Colors.black,
        ),
        foregroundColor: Colors.black,
      ),
      body:Container(
        
        decoration: BoxDecoration(
          color:Colors.green[100],
          
        ),
        child:SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children:[
              Column(
                children: const [
                  Expanded(
                    child:ChatMessages(),
                  ),
                  ChatFoot(),
                ],
              ),
              const ChatSubHeader(),
            ]
          )
        )
      )
    );
  }
}