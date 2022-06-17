
import 'package:chatin/module_common/basic/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MErrorMessage extends StatelessWidget {
  final String errorMessage;
  final dynamic Function()? onPressed;
  final bool blocked;

  const MErrorMessage({Key? key, this.errorMessage = "",this.onPressed,this.blocked=false}) : super(key: key);

   Widget _messageFormater() {
     return Text(
        errorMessage,
        style: const TextStyle(
            fontSize: 13.0,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
   }

   Widget _titleFormater() {
     return const Text("ERROR",
        style: TextStyle(
            fontSize: 18.0,
            height: 1.0,
            fontWeight: FontWeight.bold),
      );
   }

  Widget _showErrorMessage(BuildContext context) {
    if (errorMessage.isNotEmpty) {
      List<Widget> actions = [];

      if(!blocked){
        actions.add(InkWell(
          onTap: onPressed,
          child: Text(AppLocalizations.of(context)!.close,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14
            ),
          ),
        ));
      }

      
      return AlertDialog(
          title: _titleFormater(),
          content: _messageFormater(),
          actions: actions,
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
