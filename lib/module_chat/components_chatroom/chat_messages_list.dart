import 'package:chatin/module_chat/index.dart';
import 'package:chatin/module_common/models/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rect_getter/rect_getter.dart';

class ChatMessagesList extends StatefulWidget{
  const ChatMessagesList({Key? key}) : super(key: key);

  @override
  State<ChatMessagesList> createState() => _ChatMessagesListState();

}

class _ChatMessagesListState extends State<ChatMessagesList>{
  List<ChatMessage> messages = [];
  PersonUser? localPerson;
  final listViewKey = RectGetter.createGlobalKey();
  final Map<String,GlobalKey<RectGetterState>> keys = <String,GlobalKey<RectGetterState>>{};
  final ScrollController scrollController = ScrollController();

  @override
  initState(){
    if(BlocProvider.of<ChatBloc>(context).state is ChatInitialState){
      localPerson = (BlocProvider.of<ChatBloc>(context).state as ChatInitialState).localPerson;
    }

    scrollController.addListener(listenerScroll);

    super.initState();
  }

  listenerScroll(){
    ChatMessage? message = firstVisible();
    if(message!=null){
      BlocProvider.of<ChatBloc>(context).add(ChatSetDateTimeEvent(message.time));
    }
  }

  @override
  dispose(){
    scrollController.removeListener(listenerScroll);
    super.dispose();
  }

  blocListener(BuildContext context, ChatState state){
      if(state is ChatInitialState){
        localPerson = state.localPerson;
      }else if(state is ChatMessagesLoaded){
        messages = state.messages;
      }else if(state is ChatMessageSended){
        scrollController.animateTo(
          0,
          duration: const Duration(seconds: 2),
          curve: Curves.fastOutSlowIn,
        );
      }
  }

  bool blocListenerWhen(ChatState previous, ChatState current) {
    bool refresh = [ChatInitialState,ChatMessagesLoaded,ChatMessageSended].contains(current.runtimeType);
    return refresh;
  }

  Widget timeRow(DateTime dateTime){
    return Container(
          margin: const EdgeInsets.only(top:15),
          child: ChatDateItem( dateTime:dateTime));
  }

  List<Widget> _messagesGroups(){
    if(localPerson==null){
      return [];
    }

    List<Widget> widgets = [];
    DateTime? currentDate;
    keys.clear();
    for (var msg in messages) {
      DateTime localTimeMsg = msg.time.toLocal();
      DateTime initMsg = DateTime(localTimeMsg.year,localTimeMsg.month,localTimeMsg.day);
      currentDate ??= initMsg;

      if(initMsg!=currentDate){
        widgets.add(timeRow(currentDate));
        currentDate=initMsg;
      }

      keys[msg.id] = RectGetter.createGlobalKey();
      widgets.add(
        RectGetter(
          key: keys[msg.id]!,
          child: ChatMessageItem(message:msg, localPerson: localPerson!,)
        )
      );
    }

    if(currentDate!=null) widgets.add(timeRow(currentDate));

    return widgets;
  }

  ChatMessage? firstVisible() {
      Rect? rect = RectGetter.getRectFromKey(listViewKey);
      if(rect == null){
        return null;
      }
      var items = <String>[];
      keys.forEach((index, key) {
        var itemRect = RectGetter.getRectFromKey(key);
        if (itemRect != null && !(itemRect.top > rect.bottom || itemRect.bottom < rect.top)) items.add(index);
      });

      if(keys.isEmpty){
        return null;
      }

      return messages.firstWhere((element) => element.id==items.last);
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ChatBloc,ChatState>(
      listener: blocListener,
      buildWhen: blocListenerWhen,
      builder: (ctx,stat) => 
      RectGetter(
        key: listViewKey,
        child:ListView(
          controller: scrollController,
          reverse: true,
          children: _messagesGroups(),
        )
      )
    );
  }

}