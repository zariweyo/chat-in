import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatin/module_chat/models/chat.dart';
import 'package:chatin/module_common/library/utils.dart';
import 'package:flutter/material.dart';

class ChatsListCounter extends StatelessWidget{
  final Chat chat;
  
  const ChatsListCounter({Key? key, 
    required this.chat,
  }) : super(key: key);

  Color _color(){
    return Colors.transparent;
  }

  String _time(){
    return UtilsFunctions.prettyTime(chat.lastMessageTime.toLocal());
  }

  String _date(){
    if(UtilsFunctions.dateIsToday(chat.lastMessageTime)){
      return "";
    }
    return 
      UtilsFunctions.dateFormat(chat.lastMessageTime.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children:[
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: _color(),
            borderRadius: BorderRadius.circular(20),
          ),
          height: 20,
          width: 20,
        ),
        AutoSizeText(
          _date(),
          maxLines: 1,
          textAlign: TextAlign.end,
        ),
        AutoSizeText(
          _time(),
          maxLines: 1,
          textAlign: TextAlign.end,
        )
      ]
    );
  }

}