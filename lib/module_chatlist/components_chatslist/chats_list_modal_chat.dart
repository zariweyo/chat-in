import 'package:chatin/module_chat/models/index.dart';
import 'package:chatin/module_chatlist/chatslist_bloc/index.dart';
import 'package:chatin/module_common/library/messages.dart';
import 'package:chatin/module_common/models/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatListModalChat extends StatefulWidget{
  final Chat chat;
  final BuildContext parentContext;
  const ChatListModalChat({
    Key? key, 
    required this.chat,
    required this.parentContext,
  }) : super(key: key);

  @override
  State<ChatListModalChat> createState() => _ChatListModalChatState();

}

class _ChatListModalChatState extends State<ChatListModalChat>{

  @override
  void initState() {
    
    super.initState();
  }

  List<ActionEvent> getActions() {
    List<ActionEvent> actions = [];
    actions.add(
      ActionEvent(
        title: AppLocalizations.of(context)!.delete_chat,
        action: () {
          
          UtilMessages.showConfirmDialog(context, 
            AppLocalizations.of(context)!.delete_chat, 
            AppLocalizations.of(context)!.really_delete_chat,
            onAccept: (ctx) {
              BlocProvider.of<ChatsListBloc>(widget.parentContext).add(ChatsListDeleteEvent(widget.chat));
              Navigator.pop(context);
            });
        }
      )
    );

    return actions;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: getActions().map((action) => 
        InkWell(
          onTap: action.action,
          child: Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: Text(action.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20
              ),
            ),
          )
        )
      ).toList()
    );
  }

}