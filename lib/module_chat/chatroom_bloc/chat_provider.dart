import 'package:chatin/module_chat/index.dart';
import 'package:chatin/module_common/models/index.dart';
import 'package:chatin/repositories/personuser_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ChatProvider extends StatefulWidget{
  final Chat chat;

  const ChatProvider({Key? key, 
    required this.chat
  }) : super(key: key);

  @override
  State<ChatProvider> createState() => _ChatProviderState();

}

class _ChatProviderState extends State<ChatProvider>{

  late ChatBloc _bloc;
  final PersonUser localPerson = GetIt.I.get<PersonUserRepository>().user;

  @override
  void initState() {
    _bloc = ChatBloc(widget.chat,localPerson, PersonUser(id: 'RemoteId', name: 'REMOTE'));
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
      create: (BuildContext context) => _bloc..add(ChatInitialMessagesEvent()),
      child: const ChatBuilder(),
    );
  }

}