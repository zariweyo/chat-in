import 'package:chatin/module_chat/chatroom_bloc/chat_bloc.dart';
import 'package:chatin/module_chat/chatroom_bloc/chat_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatSelectedBarActions extends StatefulWidget{
  const ChatSelectedBarActions({Key? key}) : super(key: key);
  
  @override
  State<ChatSelectedBarActions> createState() => _ChatSelectedBarActionsState();

}

class _ChatSelectedBarActionsState extends State<ChatSelectedBarActions>{

  genericSelectedAction(ChatMessagesSelectedActionType action){
    BlocProvider.of<ChatBloc>(context).add(ChatMessagesSelectedActionEvent(action));
  }

  Widget button({required IconData iconData, required Function() action}){
    return InkWell(
      onTap: action,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.blue
        ),
        margin: const EdgeInsets.only(right:5),
        padding: const EdgeInsets.all(10),
        child: Icon(iconData, color: Colors.white, size: 30,)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white
      ),
      child: Row(
        children: [
          button(
            action: () => genericSelectedAction(ChatMessagesSelectedActionType.clean), 
            iconData: Icons.close),
          button(
            action: () => genericSelectedAction(ChatMessagesSelectedActionType.share), 
            iconData: Icons.share),
          button(
            action: () => genericSelectedAction(ChatMessagesSelectedActionType.copy), 
            iconData: Icons.copy)
        ],
      )
    );
  }

}