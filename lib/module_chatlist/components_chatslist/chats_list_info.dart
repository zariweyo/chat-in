import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatin/module_chat/index.dart';
import 'package:chatin/module_chatlist/chatslist_bloc/chats_list_bloc.dart';
import 'package:chatin/module_chatlist/chatslist_bloc/chats_list_events.dart';
import 'package:chatin/module_chatlist/chatslist_bloc/chats_list_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsListInfo extends StatefulWidget{
  final Chat chat;
  
  const ChatsListInfo({Key? key, 
    required this.chat
  }) : super(key: key);

  @override
  State<ChatsListInfo> createState() => _ChatsListInfoState();
}

class _ChatsListInfoState extends State<ChatsListInfo> {
  bool isEdit = false;
  late Chat currentchat;
  TextEditingController controller = TextEditingController();

  @override
  initState(){
    currentchat = widget.chat;
    super.initState();
  }

  blocListener(BuildContext context, ChatsListState state){
      if(state is ChatsListEditState && state.chat.id == widget.chat.id){
        isEdit = true;
        controller.text = currentchat.name;
      }
      if(state is ChatsListSaveState && state.chat.id == widget.chat.id){
        currentchat.name = state.chat.name;
        isEdit = false;
      }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatsListBloc,ChatsListState>(
      listener: blocListener,
      builder: (ctx,stat) => 
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              !isEdit?
                InkWell(
                  child: AutoSizeText(currentchat.name,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                  onTap: (){
                    BlocProvider.of<ChatsListBloc>(context).add(ChatsListEditEvent(widget.chat));
                  },
                ):

                Row(
                  children:[
                    Expanded(
                      child: TextField(
                        controller: controller,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                        maxLines: 2,
                        onChanged: (newName) {
                          currentchat.name = newName;
                        },
                      ),
                    ),
                    IconButton(onPressed: () {
                      BlocProvider.of<ChatsListBloc>(context).add(ChatsListSaveEvent(currentchat));
                    }, icon: const Icon(Icons.check))
                  ]
                )
            ]
          )
    );
  }
}