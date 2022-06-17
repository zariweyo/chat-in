import 'package:chatin/module_chatlist/views/chats_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chats_list_bloc.dart';
import 'chats_list_states.dart';


class ChatsListBuilder extends StatelessWidget{
  const ChatsListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<ChatsListBloc>(context),
      builder: (BuildContext context, ChatsListState state) {
        return const ChatsList();
      },
    );
  }

}