import 'package:chatin/module_chat/models/chat.dart';
import 'package:chatin/module_common/models/person_user.dart';
import 'package:flutter/material.dart';

class ChatsListIcon extends StatelessWidget{
  final Chat chat;
  final Map<String,PersonUser> persons;
  
  const ChatsListIcon(
    this.chat,
    this.persons, {Key? key}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text("AV")
      ]
    );
  }

}