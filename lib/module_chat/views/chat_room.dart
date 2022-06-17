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
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        actions: const [],
        title: const ChatHeader(),
        leading: const MBack(
          color: Colors.white,
        ),
      ),
      body:Container(
        
        decoration: BoxDecoration(
          color:Colors.green[100],
          image: DecorationImage(
            image: const AssetImage("assets/images/back1.png"),
            colorFilter: 
              ColorFilter.mode(Colors.black.withOpacity(0.1), 
              BlendMode.dstATop
            ),
            fit: BoxFit.cover,
          ),
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