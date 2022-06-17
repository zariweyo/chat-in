import 'package:chatin/module_chatlist/chatslist_bloc/index.dart';
import 'package:chatin/module_chatlist/components_chatslist/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components_chatslist/chat_list_header.dart';


class ChatsList extends StatefulWidget{
  const ChatsList({Key? key}) : super(key: key);

  @override
  State<ChatsList> createState() => _ChatsListState();


}

class _ChatsListState extends State<ChatsList>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        actions: const [],
        title: const ChatListHeader(),
      ),
      body: Center(
        child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/back1.png"),
                  fit: BoxFit.fitHeight,
                  opacity: 0.1),
            ),
            child: const ChatsListRoot()
        )
      ),
    );
  }

}