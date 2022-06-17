
import 'package:chatin/module_common/basic/index.dart';
import 'package:flutter/material.dart';

class MDecisionMessage extends StatelessWidget {
  final String infoMessage;
  final String title;
  final List<MDecisionMessageOption> options;

  const MDecisionMessage({Key? key, required this.infoMessage,this.options = const [], required this.title}) : super(key: key);

   Widget _messageFormater() {
     return Text(
        infoMessage,
        textAlign: TextAlign.justify,
        style: const TextStyle(
            fontSize: 13.0,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
   }

   Widget _titleFormater() {
     return Text(
        title,
        style: const TextStyle(
            fontSize: 18.0,
            height: 1.0,
            fontWeight: FontWeight.bold),
      );
   }

  printOptions(BuildContext context){
    List<Widget> optionsOut = [];
    for (var option in options) {
      optionsOut.add(
        InkWell(
          onTap: () {
                option.onPress(context);
          },
          child: Text(option.title,), 
          )
      );
    }
    return optionsOut;
  }

  Widget _showErrorMessage(BuildContext context) {
    if (infoMessage.isNotEmpty) {
      
      return AlertDialog(
          title: _titleFormater(),
          content: _messageFormater(),
          actions: printOptions(context),
        );
    } else {
      return const MEmpty();
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return _showErrorMessage(context);
  }
}

class MDecisionMessageOption{
  String title;
  Function(BuildContext) onPress;

  MDecisionMessageOption({required this.title, required this.onPress});

}
