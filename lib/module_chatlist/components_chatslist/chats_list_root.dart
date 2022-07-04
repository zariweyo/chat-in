import 'package:chatin/module_chat/index.dart';
import 'package:chatin/module_chatlist/chatslist_bloc/index.dart';
import 'package:chatin/module_chatlist/components_chatslist/index.dart';
import 'package:chatin/module_common/models/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';


class ChatsListRoot extends StatefulWidget{
  const ChatsListRoot({Key? key}) : super(key: key);

  @override
  State<ChatsListRoot> createState() => _ChatsListRootState();

}

class _ChatsListRootState extends State<ChatsListRoot>{
  List<Chat> _chats = [];
  Map<String,PersonUser> _persons = {};

  @override
  initState(){

    super.initState();
  }

  blocListener(BuildContext context, ChatsListState state){
      if(state is ChatsListChatsLoadedState){
        _chats = state.chats;
        _persons = state.persons;
      }

      if(state is ChatsListDeleteState){
        _chats = _chats.where((element) => element.id!=state.chat.id).toList();
      }
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ChatsListBloc,ChatsListState>(
      listener: blocListener,
      builder: (ctx,stat) => 
        Container(
          alignment: Alignment.topCenter,
          child: ResponsiveGridList(
            horizontalGridSpacing: 16, 
            verticalGridSpacing: 16, 
            horizontalGridMargin: 20, 
            verticalGridMargin: 20, 
            minItemWidth: 300,
            minItemsPerRow: 1,
            maxItemsPerRow: 5,
            shrinkWrap: true,
            children: _chats.map((chat) => 
              ChatsListItem(
                key: Key(chat.id),
                chat: chat,
                persons: _persons
              )
            ).toList()
          )
        )
    );
  }

}