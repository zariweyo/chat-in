import 'package:chatin/module_chat/chatroom_bloc/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatSendButton extends StatefulWidget{
  final Function(bool)? onSend;

  const ChatSendButton({Key? key, 
    this.onSend
  }) : super(key: key);
  
  @override
  State<ChatSendButton> createState() => _ChatSendButtonState();

}

class _ChatSendButtonState extends State<ChatSendButton>{

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        BlocProvider.of<ChatBloc>(context).add(ChatSendMessage());
        if(widget.onSend!=null) widget.onSend!(true);
      },
      child:Container(
        margin: const EdgeInsets.only(right:5,bottom: 3,top:3),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.blue
        ),
        child: const Icon(Icons.send,
          color: Colors.white,
          size: 30,
        )
      )
    );
  }

}