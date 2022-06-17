
import 'package:chatin/module_common/basic/index.dart';
import 'package:flutter/material.dart';

class UtilMessages
{
  static showInfoDialog(BuildContext context, String title, String infoMessage,
    {VoidCallback? onFinish, bool barrierDismissible=true, bool autoCloseAfter=true}) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        // return object of type Dialog
        return MInfoMessage(
          title: title,
          infoMessage: infoMessage,
          onPressed: () {
            if(onFinish!=null) onFinish();
            if(autoCloseAfter) Navigator.of(context).pop();
          }

        );
      },
    );
  }

  static showHtmlDialog(BuildContext context, String title, String html,
    {VoidCallback? onFinish, bool barrierDismissible=true, bool autoCloseAfter=true}) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        // return object of type Dialog
        return MInfoMessageHTML(
          title: title,
          html: html,
          onPressed: () {
            if(onFinish!=null) onFinish();
            if(autoCloseAfter) Navigator.of(context).pop();
          }

        );
      },
    );
  }

  static showDecisionDialog(BuildContext context, String title, String infoMessage,List<MDecisionMessageOption> options) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return MDecisionMessage(
          title: title,
          infoMessage: infoMessage,
          options:options

        );
      },
    );
  }

  static showConfirmDialog(BuildContext context, String title, String confirmationMessage,{Function(BuildContext)? onAccept, Function(BuildContext)? onDeny}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return MConfirmationMessage(
          title: title,
          confirmationMessage: confirmationMessage,
          onAccept: () {
            
            
            Navigator.of(context).pop();
            if(onAccept!=null) onAccept(context);
          },
          onDeny: () {
            
            Navigator.of(context).pop();
            if(onDeny!=null) onDeny(context);
          },

        );
      },
    );
  }

  

  static showErrorDialog(BuildContext context, String errorMessage,{VoidCallback? onFinish, bool blocked=false}) {
    // TODO control Globals.errorIsShowing
    // Original if (!Globals.errorIsShowing && _errorMessage != null && _errorMessage.length > 0) {
    // Original  Globals.errorIsShowing = true;
    if (errorMessage.isNotEmpty) {
      //Globals.errorIsShowing = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return MErrorMessage(
            blocked: blocked,
            errorMessage: errorMessage,
            onPressed: (){
              if(onFinish!=null) onFinish();
              //Globals.errorIsShowing = false;
              Navigator.of(context).pop();
            },
            
          );
        },
      );
    }
  }
}