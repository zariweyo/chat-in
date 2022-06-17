import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatin/module_chat/chatroom_bloc/index.dart';
import 'package:chatin/module_common/basic/index.dart';
import 'package:chatin/module_common/library/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatMessageAdvice extends StatefulWidget{
  const ChatMessageAdvice({Key? key}) : super(key: key);
  
  @override
  State<ChatMessageAdvice> createState() => _ChatMessageAdviceState();
}

class _ChatMessageAdviceState extends State<ChatMessageAdvice> {

  int messagesLength = 0;

  blocListener(BuildContext context, ChatState state){
      if(state is ChatMessagesLoaded){
        messagesLength = (BlocProvider.of<ChatBloc>(context).state as ChatMessagesLoaded).messages.length;
      }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc,ChatState>(
      listener: blocListener,
      builder: (ctx,stat) {
        if(messagesLength>10){
          return const MEmpty();
        }

        return InkWell(
          onTap: (){
            UtilMessages.showInfoDialog(context, 
              AppLocalizations.of(context)!.chat_advice_title, 
              AppLocalizations.of(context)!.chat_advice_info);
          },
          child:Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(5)
            ),
            child: AutoSizeText(
              AppLocalizations.of(context)!.chat_advice_reduce
            )
          )
        );
      }
    );
  }
}