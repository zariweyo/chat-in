import 'package:chatin/module_chatlist/chatslist_bloc/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListHeader extends StatefulWidget{
  const ChatListHeader({Key? key}) : super(key: key);

  @override
  State<ChatListHeader> createState() => _ChatHeaderState();

}

class _ChatHeaderState extends State<ChatListHeader>{

  @override
  void initState() {
    
    super.initState();
  }

  void addNewList(){
    BlocProvider.of<ChatsListBloc>(context).add(ChatsListAddEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        //color: Colors.white
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text("CHAT-IN")
          ),
          IconButton(onPressed: addNewList, icon: const Icon(Icons.add_circle))
          //_buttonClean()
        ]
      )
    );
  }

}