
import 'package:chatin/module_common/basic/index.dart';
import 'package:flutter/material.dart';

class MConfirmationMessage extends StatelessWidget {
  final String confirmationMessage;
  final String title;
  final dynamic Function()? onAccept;
  final dynamic Function()? onDeny;

  const MConfirmationMessage({Key? key, required this.confirmationMessage,this.onAccept,this.onDeny, required this.title}) : super(key: key);

   Widget _messageFormater() {
     return Text(
        confirmationMessage,
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

  Widget _showConformationMessage(BuildContext context) {
    if (confirmationMessage.isNotEmpty) {
      
      return AlertDialog(
          title: _titleFormater(),
          content: _messageFormater(),
          actions: <Widget>[
            InkWell(
              onTap: onAccept,
              child: const Icon(
                Icons.done,
                color:Colors.green
              )
            ),
            InkWell(
              onTap: onDeny,
              child: const Icon(
                Icons.cancel,
                color:Colors.red
              )
            ),
          ],
        );
    } else {
      return const MEmpty();
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return _showConformationMessage(context);
  }
}
