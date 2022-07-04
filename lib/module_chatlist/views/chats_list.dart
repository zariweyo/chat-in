import 'package:chatin/module_chatlist/components_chatslist/index.dart';
import 'package:flutter/material.dart';

import '../components_chatslist/chats_list_header.dart';


class ChatsList extends StatefulWidget{
  const ChatsList({Key? key}) : super(key: key);

  @override
  State<ChatsList> createState() => _ChatsListState();


}

class _ChatsListState extends State<ChatsList>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        elevation: 0,
        actions: const [],
        title: const ChatListHeader(),
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/icons/todo_logo.png"),
                  fit: BoxFit.scaleDown,
                  opacity: 0.1),
            ),
            child: const ChatsListRoot()
        )
      ),
    );
  }

}