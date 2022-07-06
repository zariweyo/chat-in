import 'package:flutter/material.dart';

class ChatBarActionsButton extends StatelessWidget{
  final IconData iconData;
  final Function() action;
  final bool hide;

  const ChatBarActionsButton({
    Key? key, 
    required this.iconData, 
    required this.action, 
    this.hide = false
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    if(hide){
      return Container();
    }
    return InkWell(
      onTap: action,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.blue
        ),
        margin: const EdgeInsets.only(right:5),
        padding: const EdgeInsets.all(10),
        child: Icon(iconData, color: Colors.white, size: 30,)
      ),
    );
  } 
}