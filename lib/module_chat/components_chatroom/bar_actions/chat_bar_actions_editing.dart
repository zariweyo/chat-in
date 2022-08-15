import 'package:chatin/module_chat/components_chatroom/bar_actions/chat_bar_actions_base.dart';
import 'package:chatin/module_chat/components_chatroom/bar_actions/chat_bar_actions_button.dart';
import 'package:chatin/module_chat/index.dart';
import 'package:chatin/module_hive/adapters/chat_message_field_hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBarActionsEditing extends StatefulWidget{
  const ChatBarActionsEditing({Key? key}) : super(key: key);
  
  @override
  State<ChatBarActionsEditing> createState() => _ChatBarActionsEditingState();

}

class _ChatBarActionsEditingState extends State<ChatBarActionsEditing>{
  ChatMessage? chatMessage;

  genericSelectedAction(ChatBarEditActionType action){
    BlocProvider.of<ChatBloc>(context).add(ChatMessagesEditingActionEvent(action));
  }

  @override
  void initState() {
    chatMessage = BlocProvider.of<ChatBloc>(context).currentChatMessage;
    super.initState();
  }

  blocListener(BuildContext context, ChatState state){
      if(state is ChatMessagesEditingActionState){
      }
  }

  bool blocListenerWhen(ChatState previous, ChatState current) {
    return current is ChatMessagesEditingActionState;
  }

  @override
  Widget build(BuildContext context) {
    if(chatMessage == null){
      return Container();
    }

    return BlocConsumer<ChatBloc,ChatState>(
      listener: blocListener,
      buildWhen: blocListenerWhen,
      builder: (ctx,stat) => 
        ChatBarActionsBase(
          textDirection: TextDirection.rtl,
          children: [
            ChatBarActionsButton(
              action: () => genericSelectedAction(ChatBarEditActionType.save), 
              iconData: Icons.check),
            ChatBarActionsButton(
              hide: (chatMessage?.fields?.where((element) => element.type == ChatMessageFieldType.num).isNotEmpty??false),
              action: () => genericSelectedAction(ChatBarEditActionType.newNumField), 
              iconData: Icons.money)
          ]
        )
    );
  }

}