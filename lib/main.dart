import 'package:chatin/start_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:chatin/repositories/index.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  final ENV enviroment;
  const MyApp({Key? key, this.enviroment = ENV.prod}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool loading = true;

  @override
  void initState() {
    StartApp.registers(context, widget.enviroment).then((value) => {
      setState((){
        loading = false;
      })
    });

    super.initState();
  }

  Widget base(){
    if(loading){
      return const CircularProgressIndicator();
    }

    return const HomePage();
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Rick and Morty',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
      ],
      home: base(),
    );
  }
}
