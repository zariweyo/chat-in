import 'package:chatin/module_chat/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatTextField extends StatefulWidget{
   final ValueStream<bool> cleanListener;

   const ChatTextField({Key? key, 
     required this.cleanListener
   }) : super(key: key);

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();

}

class _ChatTextFieldState extends State<ChatTextField>{
  late TextEditingController _controller;

  @override
  initState(){
    _controller = TextEditingController();
    widget.cleanListener.listen((data) {
      _controller.clear();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical:3,horizontal:20),
      margin: const EdgeInsets.only(top:3,bottom:3,left:5,right: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5)
      ),
      child: TextField(
        controller: _controller,
        cursorColor: Colors.black,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        minLines: 1,
        maxLines: 6,
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical:5,horizontal:5),
            hintText: AppLocalizations.of(context)!.write_a_message
        ),
        onChanged: (str){
          if(str.isEmpty){
            BlocProvider.of<ChatBloc>(context).add(ChatIWritingMessage(false));
          }else if(str.length==3 || str.length%20==0){
            BlocProvider.of<ChatBloc>(context).add(ChatIWritingMessage(true));
          }
          BlocProvider.of<ChatBloc>(context).add(ChatSetMessage(str));
        },
      )
    );
  }

}
