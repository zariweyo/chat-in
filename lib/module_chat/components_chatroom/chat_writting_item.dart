import 'package:chatin/module_chat/models/index.dart';
import 'package:chatin/module_common/basic/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class ChatWritingItem extends StatefulWidget{
  final ChatWriting chatWriting;


  const ChatWritingItem({
    Key? key,
    required this.chatWriting
  }) : super(key: key);

  @override
  State<ChatWritingItem> createState() => _ChatWritingItemState();
}

class _ChatWritingItemState extends State<ChatWritingItem>{

  bool _show=false;

  @override
  void initState() {
    if(!_chekTimeExceded()){
      _show=true;
      _timeOut();
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ChatWritingItem oldWidget) {
    if(!_chekTimeExceded() && !_show){
      setState(() {
        _show=true;
      });
      _timeOut();
    }
    super.didUpdateWidget(oldWidget);
  }

  _chekTimeExceded(){
    return DateTime.now().toUtc().difference(widget.chatWriting.time).inSeconds > 10;
  }

  _timeOut(){
    Future.delayed(const Duration(seconds:3),(){
      if(!mounted){
        _show=false;
        return;
      }

      if(_chekTimeExceded()){
        setState(() {
          _show=false;
        });
      }else{
        _timeOut();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(!_show || !widget.chatWriting.isWriting){
      return const MEmpty();
    }

    return Container(
      padding: const EdgeInsets.all(5),
      width: 100,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(
        left: 5,
        top:10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
      ),
      child: SpinKitThreeBounce(
        color: Theme.of(context).primaryColorLight,
        size: 20.0,
      )
    );
  }
}