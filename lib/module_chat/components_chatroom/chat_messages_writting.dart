import 'package:chatin/module_chat/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessagesWritting extends StatefulWidget{
  const ChatMessagesWritting({Key? key}) : super(key: key);

  @override
  State<ChatMessagesWritting> createState() => _ChatMessagesWrittingState();
}

class _ChatMessagesWrittingState extends State<ChatMessagesWritting>{
  List<ChatWriting> writings = [];

  blocListener(BuildContext context, ChatState state){
      if(state is ChatMessagesWritingChange){
        writings = (BlocProvider.of<ChatBloc>(context).state as ChatMessagesWritingChange).chatWriting;
      }
  }

  Widget _messageWritting(){
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerLeft,
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: writings.map((item) => ChatWritingItem(chatWriting:item)).toList(),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc,ChatState>(
      listener: blocListener,
      builder: (ctx,stat) => _messageWritting()
    );
  }

}