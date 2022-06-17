import 'package:chatin/module_chat/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ChatBuilder extends StatelessWidget{
  const ChatBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<ChatBloc>(context),
      builder: (BuildContext context, ChatState state) {
        return const ChatRoom();
      },
    );
  }

}