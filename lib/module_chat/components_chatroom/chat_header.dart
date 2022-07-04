import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatin/module_chat/index.dart';
import 'package:chatin/module_common/models/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatHeader extends StatefulWidget{
  const ChatHeader({Key? key}) : super(key: key);

  @override
  State<ChatHeader> createState() => _ChatHeaderState();

}

class _ChatHeaderState extends State<ChatHeader>{
  PersonUser remotePerson = PersonUser(id: '');
  late StreamSubscription subscription;

  @override
  void initState() {

    if(BlocProvider.of<ChatBloc>(context).state is ChatInitialState){
      remotePerson = (BlocProvider.of<ChatBloc>(context).state as ChatInitialState).remotePerson;
    }
    
    super.initState();
  }

  @override
  didUpdateWidget(ChatHeader oldWidget){

    if(BlocProvider.of<ChatBloc>(context).state is ChatMessagesPersonReloaded){
      remotePerson = (BlocProvider.of<ChatBloc>(context).state as ChatMessagesPersonReloaded).person;
    }

    super.didUpdateWidget(oldWidget);
  }

  _name(){
    return Container(
      margin: const EdgeInsets.only(left:10),
      child:AutoSizeText(remotePerson.name??="",
        maxLines: 2,
        style: const TextStyle(
          color:Colors.black
        ),
      )
    );
  }

  _lastConnected(){
    Duration durationLastConnected = DateTime.now().difference(remotePerson.updated.toLocal());
    String text = "";
    if(durationLastConnected.inDays>30){
      text = AppLocalizations.of(context)!.viewed_more_than_a_lot;
    }if(durationLastConnected.inDays>7){
      text = AppLocalizations.of(context)!.viewed_more_than_a_week;
    }else if(durationLastConnected.inDays>1){
      text = "${AppLocalizations.of(context)!.viewed_for_a_days} ${durationLastConnected.inDays}";
    }else if(durationLastConnected.inDays>0){
      text = AppLocalizations.of(context)!.viewed_for_a_day;
    }else if(durationLastConnected.inHours>1){
      text = "${AppLocalizations.of(context)!.viewed_for_a_hours} ${durationLastConnected.inHours}";
    }else if(durationLastConnected.inHours>0){
      text = AppLocalizations.of(context)!.viewed_for_a_hour;
    }else if(durationLastConnected.inMinutes>1){
      text = "${AppLocalizations.of(context)!.viewed_for_a_minutes} ${durationLastConnected.inMinutes}";
    }else{
      text = AppLocalizations.of(context)!.viewed_nearly;
    }

    return Container(
      margin: const EdgeInsets.only(left:10),
      child:AutoSizeText(text,
        maxLines: 1,
        style: const TextStyle(
          color:Colors.black,
          fontSize: 9
        ),
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        //color: Colors.white
      ),
      child: Row(
        children:[
          const Text("AV"),
          Expanded(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                _name(),
                _lastConnected()
              ]
            )
          ),
          //_buttonClean()
        ]
      )
    );
  }

}