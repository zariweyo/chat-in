import 'package:chatin/module_chat/index.dart';
import 'package:chatin/module_common/models/index.dart';
import 'package:chatin/module_hive/adapters/chat_message_hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ChatMessageItemStyle{
  final Color backgroudColor;
  double left;
  double right;

  ChatMessageItemStyle({
    required this.backgroudColor,
    required this.left,
    required this.right,
  });

  factory ChatMessageItemStyle.userChat(ChatMessage message){
    return ChatMessageItemStyle(
        backgroudColor: Colors.greenAccent.shade100,
        left: 50 ,
        right: 5,
    );
  }

  factory ChatMessageItemStyle.otherChat(ChatMessage message){
    return ChatMessageItemStyle(
        backgroudColor: Colors.white,
        left: 5,
        right: 50,
    );
  }
}

enum SelectedState {
  none,
  selected
}

class ChatMessageItem extends StatefulWidget{
  final ChatMessage message;
  final PersonUser localPerson;
  
  const ChatMessageItem({Key? key, 
    required this.message,
    required this.localPerson,
  }) : super(key: key);

  @override
  State<ChatMessageItem> createState() => _ChatMessageItemState();
}

class _ChatMessageItemState extends State<ChatMessageItem> {
  late ChatMessageItemStyle _style;
  bool _isMyMessage = false;
  SelectedState selectedState = SelectedState.none;
  bool anySelected = false;

  @override
  initState(){
    if(widget.message.fromUserId==widget.localPerson.id){
      _isMyMessage=true;
      _style = ChatMessageItemStyle.userChat(widget.message);
    }else{
      _style = ChatMessageItemStyle.otherChat(widget.message);
    }
    super.initState();
  }

  _timeString(){
    String hour = widget.message.time.toLocal().hour.toString();
    String minute = widget.message.time.toLocal().minute.toString();
    if(widget.message.time.minute<10) minute = "0${widget.message.time.minute}";

    return "$hour:$minute";
  }

  _iconState(){
    if(!_isMyMessage){
      return Container();
    }

    IconData iconData = Icons.timer_off;
    Color color = Colors.blue.shade200;
    double size = 15;
    switch(widget.message.state){
      case ChatMessageState.repeat:
      case ChatMessageState.writing:
        iconData = Icons.timer;
        color = Colors.blue.shade200;
        break;
      case ChatMessageState.sended:
      case ChatMessageState.received:
        iconData = Icons.done;
        color = Colors.blue.shade200;
        size = 15;
        break;
      case ChatMessageState.readed:
      case ChatMessageState.verified:
        iconData = Icons.done_all;
        color = Colors.blue.shade300;
        size = 15;
        break;
    }

    return Icon(iconData,color:color, size:size);
  }

  _print(BuildContext context){

    switch(widget.message.type){

      case ChatMessageType.text:
        return _printAsText();
      
      case ChatMessageType.none:
      default:
        return _unknown(context);
    }
  }

  _unknown(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(5)
      ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.message_version_deprecated,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children:[
              Expanded(
                child:Text(_timeString(),
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12
                  ),
                )
              ),
              const SizedBox(width:5),
              _iconState()
            ]
          )
        ],
      )
    );
  }

  _printAsText(){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChatMessageText(
            message: widget.message,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children:[
              Expanded(
                child:Text(_timeString(),
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12
                  ),
                )
              ),
              const SizedBox(width:5),
              _iconState()
            ]
          )
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return 
    BlocSelector<ChatBloc,ChatState,SelectedState?>(
      selector: (state) {
        if(state is ChatMessagesSelectedState) {
          anySelected = state.messages.isNotEmpty;
          if(state.messages.where((ms) => ms.id == widget.message.id).isNotEmpty){
            selectedState = SelectedState.selected;
          }else {
            selectedState = SelectedState.none;
          }
        }
        return selectedState;
      },
      builder: (ctx,selectedState) => 
        GestureDetector(
          key: Key(widget.message.id),
          onLongPress: () {
            BlocProvider.of<ChatBloc>(context).add(ChatMessageSelectedEvent(widget.message));
          },
          onTap: () {
            if(anySelected) BlocProvider.of<ChatBloc>(context).add(ChatMessageSelectedEvent(widget.message));
          },
          child: Slidable(
            key: Key(widget.message.id),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(
                onDismissed: () {
                  BlocProvider.of<ChatBloc>(context).add(ChatMessageDeleteEvent(widget.message.id));
                }
              ),
              children: [
                SlidableAction(
                  onPressed: (ctx) {
                    Clipboard.setData(ClipboardData(text: widget.message.message));
                  },
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black,
                  icon: Icons.copy
                ),
                SlidableAction(
                  onPressed: (ctx) {
                    BlocProvider.of<ChatBloc>(context).add(ChatEditMessageEvent(widget.message));
                  },
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black,
                  icon: Icons.edit
                )
              ],
            ),
            child:Container(
              padding: const EdgeInsets.all(5),
              margin: EdgeInsets.only(
                left: _style.left,
                top:10,
                right: _style.right,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: widget.message.visible? 
                  selectedState==SelectedState.selected? 
                    Colors.green.shade300
                      : _style.backgroudColor
                    : Colors.grey
              ),
              child: _print(context)
            )
          )
        )
      );
  }
}