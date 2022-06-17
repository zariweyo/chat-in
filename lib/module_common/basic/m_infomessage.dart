
import 'package:chatin/module_common/basic/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MInfoMessage extends StatelessWidget {
  final String infoMessage;
  final String title;
  final dynamic Function()? onPressed;

  const MInfoMessage({Key? key, required this.infoMessage,this.onPressed, required this.title}) : super(key: key);

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

  Widget _showErrorMessage(BuildContext context) {
    if (infoMessage.isNotEmpty) {
      
      return AlertDialog(
        
          title: _titleFormater(),
          content: _messageFormater(),
          actions: <Widget>[
            InkWell(
              onTap: onPressed,
              child: Text(AppLocalizations.of(context)!.accept,
              style: const TextStyle(
                color: Colors.blue
              ),),
              
            ),
          ],
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
