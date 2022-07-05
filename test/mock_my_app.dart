import 'package:chatin/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MockMyApp extends StatelessWidget {
  const MockMyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
                title: 'TO-DO',
                theme: ThemeData(
                        primarySwatch: Colors.blue,
                ),
                localizationsDelegates: const [
                        AppLocalizations.delegate
                ],
                locale: const Locale('en', ''),
                home: const HomePage(),
        )
    );
  }
}