import 'package:flutter/material.dart';

class ChatBarActionsBase extends StatelessWidget{
  final List<Widget> children;
  final TextDirection textDirection;
  
  const ChatBarActionsBase({
    Key? key, 
    required this.children,
    this.textDirection = TextDirection.ltr
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white
      ),
      child: Row(
        textDirection: textDirection,
        children: children,
      )
    );
  } 
}