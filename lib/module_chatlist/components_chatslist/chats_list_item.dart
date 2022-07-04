import 'package:chatin/module_chat/chatroom_bloc/chat_provider.dart';
import 'package:chatin/module_chat/models/chat.dart';
import 'package:chatin/module_chatlist/chatslist_bloc/chats_list_bloc.dart';
import 'package:chatin/module_chatlist/chatslist_bloc/chats_list_events.dart';
import 'package:chatin/module_chatlist/components_chatslist/index.dart';
import 'package:chatin/module_common/models/person_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ChatsListItem extends StatelessWidget{
  final Chat chat;
  final Map<String,PersonUser> persons;


  const ChatsListItem({Key? key, 
    required this.chat,
    required this.persons,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return 
    InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatProvider(key: Key(chat.id), chat: chat,)),
        );
      },
      onLongPress: (){
        BlocProvider.of<ChatsListBloc>(context).add(ChatsListModalChatEvent(context, chat));
      },
      child: Card(
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.yellowAccent.shade100,
        borderOnForeground: false,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            
          ),
          width: MediaQuery.of(context).size.width,
          height: 100,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                flex:4,
                child: ChatsListInfo(
                  chat:chat
                )
              ),
              Expanded(
                flex:1,
                child: ChatsListCounter(
                  chat: chat,
                )
              )
            ],
          )
        )
      )
    );
  }

}