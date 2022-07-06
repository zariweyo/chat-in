import 'package:chatin/module_chat/components_chatroom/item_text/chat_message_edit_text.dart';
import 'package:chatin/module_chat/components_chatroom/item_text/chat_message_rich_text.dart';
import 'package:chatin/module_chat/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessageText extends StatefulWidget{
  final ChatMessage message;
  
  const ChatMessageText({Key? key, 
    required this.message,
  }) : super(key: key);

  @override
  State<ChatMessageText> createState() => _ChatMessageTextState();
}

class _ChatMessageTextState extends State<ChatMessageText> {

  late ChatMessage currentMessage; 
  bool currentEdit = false;

  @override
  initState(){
    currentMessage = widget.message;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return BlocSelector<ChatBloc,ChatState,bool>(
      selector: (state) {
        if(state is ChatEditMessageState) {
          currentEdit = state.message.id==widget.message.id;
        }
        if(state is ChatSaveMessageState) {
          if(state.message.id==widget.message.id){
            currentEdit = false;
          }
        }
        return currentEdit;
      },
      builder: (ctx,isEdit) => 
      isEdit?
        ChatMessageEditText(
          message: currentMessage,
        )
      :
        ChatMessageRichText(
          message: currentMessage,
        )
    );
  }
}