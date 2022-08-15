import 'package:chatin/module_chat/chatroom_bloc/chat_bloc.dart';
import 'package:chatin/module_chat/chatroom_bloc/chat_events.dart';
import 'package:chatin/module_chat/chatroom_bloc/chat_states.dart';
import 'package:chatin/module_chat/components_chatroom/bar_actions/chat_bar_actions_base.dart';
import 'package:chatin/module_chat/components_chatroom/bar_actions/chat_bar_actions_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBarActionsSelected extends StatefulWidget{
  const ChatBarActionsSelected({Key? key}) : super(key: key);
  
  @override
  State<ChatBarActionsSelected> createState() => _ChatBarActionsSelectedState();

}

class _ChatBarActionsSelectedState extends State<ChatBarActionsSelected>{

  bool _hasOnlyOneSelected = true;

  genericSelectedAction(ChatBarActionType action){
    BlocProvider.of<ChatBloc>(context).add(ChatMessagesSelectedActionEvent(action));
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChatBloc,ChatState,bool>(
      selector: (state) {
        if(state is ChatMessagesSelectedState) {
          _hasOnlyOneSelected = state.messages.length==1;
        }
        return _hasOnlyOneSelected;
      }, 
      builder: (ctx,onlyOneSelected) => 
        ChatBarActionsBase(
            children: [
              ChatBarActionsButton(
                action: () => genericSelectedAction(ChatBarActionType.clean), 
                iconData: Icons.close),
              ChatBarActionsButton(
                action: () => genericSelectedAction(ChatBarActionType.share), 
                iconData: Icons.share),
              ChatBarActionsButton(
                action: () => genericSelectedAction(ChatBarActionType.copy), 
                iconData: Icons.copy),
              ChatBarActionsButton(
                hide: !onlyOneSelected,
                action: () => genericSelectedAction(ChatBarActionType.edit), 
                iconData: Icons.edit)
            ]
        )
    );
  }

}