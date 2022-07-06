import 'package:chatin/module_chat/chatroom_bloc/chat_bloc.dart';
import 'package:chatin/module_chat/chatroom_bloc/chat_events.dart';
import 'package:chatin/module_chat/components_chatroom/bar_actions/chat_bar_actions_base.dart';
import 'package:chatin/module_chat/components_chatroom/bar_actions/chat_bar_actions_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBarActionsEditing extends StatefulWidget{
  const ChatBarActionsEditing({Key? key}) : super(key: key);
  
  @override
  State<ChatBarActionsEditing> createState() => _ChatBarActionsEditingState();

}

class _ChatBarActionsEditingState extends State<ChatBarActionsEditing>{

  genericSelectedAction(ChatBardActionType action){
    BlocProvider.of<ChatBloc>(context).add(ChatMessagesEditingActionEvent(action));
  }

  @override
  Widget build(BuildContext context) {
    return ChatBarActionsBase(
      textDirection: TextDirection.rtl,
      children: [
        ChatBarActionsButton(
          action: () => genericSelectedAction(ChatBardActionType.save), 
          iconData: Icons.check)
      ]
    );
  }

}