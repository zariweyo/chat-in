import 'package:flutter/material.dart';

class MBack extends StatefulWidget{
  
  final Function()? onPressed;
  final dynamic object;
  final Color? color;

  const MBack({Key? key, 
    this.onPressed,
    this.object,
    this.color,
  }) : super(key: key);

  @override
  State<MBack> createState() => _MBackState();
}

class _MBackState extends State<MBack> {
  late Color? color;


  @override
  void initState() {
    color = widget.color ?? Theme.of(context).primaryColorLight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon:Icon(Icons.arrow_back_ios, color:widget.color),
      onPressed: (){
        if(widget.onPressed!=null){
          widget.onPressed!();
        }else{
          Navigator.of(context).pop(widget.object);
        }
      },
    );
  }
}