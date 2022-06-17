import 'package:chatin/module_chat/index.dart';
import 'package:chatin/module_common/basic/m_empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatSubHeader extends StatefulWidget{

  const ChatSubHeader({Key? key}) : super(key: key);

  @override
  State<ChatSubHeader> createState() => _ChatSubHeaderState();
}

class _ChatSubHeaderState extends State<ChatSubHeader> {
  DateTime dateTime = DateTime.now();
  bool hide = true;

  blocListener(BuildContext context, ChatState state){
      if(state is ChatSetDateTimeState){
        dateTime = (BlocProvider.of<ChatBloc>(context).state as ChatSetDateTimeState).dateTime;
        hide = false;
      }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc,ChatState>(
      listener: blocListener,
      builder: (ctx,stat) => 
      hide?
        const MEmpty()
      :
        Container(
          height:35,
          decoration: const BoxDecoration(
            color: Colors.transparent
          ),
          child:ChatDateItem(dateTime: dateTime)
        )
    );
  }
}