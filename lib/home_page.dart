import 'package:flutter/material.dart';
import 'module_chatlist/chatslist_bloc/chats_list_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ChatsListProvider();
  }
}
