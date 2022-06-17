import 'package:chatin/module_common/library/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatDateItem extends StatelessWidget{
  final DateTime dateTime;

  const ChatDateItem({Key? key, 
    required this.dateTime
  }) : super(key: key);

  String _textTime(BuildContext context){
    DateTime now = DateTime.now().toLocal();
    DateTime today = DateTime(now.year,now.month,now.day);
    DateTime dateTimeAbs = DateTime(dateTime.year,dateTime.month,dateTime.day);
    if(today==dateTimeAbs){
      return AppLocalizations.of(context)!.today;
    }
    if(today.difference(dateTimeAbs).inDays==1){
      return AppLocalizations.of(context)!.yesterday;
    }
    return UtilsFunctions.prettyDate(context, dateTime);
  }


  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children:[
        Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(left: 5,right:5,top: 5,bottom: 0),
          width: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.green
          ),
          child: Text(_textTime(context),
            textAlign: TextAlign.center,
            style:const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white
            )
          )
        )
      ]
    );
  }
}