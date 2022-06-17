import 'package:flutter/material.dart';

class ChatsListIconMenu extends StatefulWidget{
  const ChatsListIconMenu({Key? key}) : super(key: key);

  @override
  ChatsListIconMenuState createState() => ChatsListIconMenuState();

}

class ChatsListIconMenuState extends State<ChatsListIconMenu> with TickerProviderStateMixin{

  bool hasMessages = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    // TODO messagesPendingChange
    /* 
    Globals.messagesPendingChange.listen((value) {
      if(value!=null){
        if(mounted){
          setState(() {
            _hasMessages = value;
          });
        }
      }
    }); */
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _container(){
    return ScaleTransition(
        scale: _animation,
        child: const Icon(
          Icons.comment,
          color: Colors.blueAccent,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    if(hasMessages){
      return _container();
    }
    return const Icon(Icons.comment);
  }

}