import 'package:chatin/module_chat/index.dart';
import 'package:chatin/module_hive/adapters/chat_message_field_hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessageEditText extends StatefulWidget{
  final ChatMessage message;
  
  const ChatMessageEditText({Key? key, 
    required this.message,
  }) : super(key: key);

  @override
  State<ChatMessageEditText> createState() => _ChatMessageEditTextState();
}

class _ChatMessageEditTextState extends State<ChatMessageEditText> {

  late ChatMessage currentMessage; 
  TextEditingController controller = TextEditingController();
  bool currentEdit = false;

  @override
  initState(){
    currentMessage = widget.message;
    controller.text = currentMessage.message;
    super.initState();
  }

  saveAction(){
    BlocProvider.of<ChatBloc>(context).add(ChatSaveMessageEvent(currentMessage));
  }

  blocListener(BuildContext context, ChatState state){
      if(state is ChatMessagesEditingActionState && state.action == ChatBarEditActionType.save){
        saveAction();
      }else if(state is ChatMessagesEditingActionState && state.action == ChatBarEditActionType.newNumField){
        currentMessage.addField(ChatMessageFieldType.num);
      }
  }

  bool blocListenerWhen(ChatState previous, ChatState current) {
    return false;
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ChatBloc,ChatState>(
      listener: blocListener,
      buildWhen: blocListenerWhen,
      builder: (ctx,isEdit) => 
        Row(
          children:[
            Expanded(
              child: TextField(
                controller: controller,
                maxLines: 3,
                onChanged: (newMessage) {
                  currentMessage.message = newMessage;
                },
              ),
            ),
            IconButton(onPressed: saveAction, icon: const Icon(Icons.check))
          ]
        )
    );
  }

}