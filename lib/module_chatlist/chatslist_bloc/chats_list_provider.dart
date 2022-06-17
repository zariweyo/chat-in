import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'index.dart';

class ChatsListProvider extends StatefulWidget{

  const ChatsListProvider({Key? key}) : super(key: key);

  @override
  State<ChatsListProvider> createState() => _ChatsListProviderState();

}

class _ChatsListProviderState extends State<ChatsListProvider>{

  late ChatsListBloc _bloc;

  @override
  void initState() {
    _bloc = ChatsListBloc();
    super.initState();
  }

  @override
  dispose(){
    _bloc.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _bloc..add(ChatsListInitialEvent()),
      child: const ChatsListBuilder(),
    );
  }

}