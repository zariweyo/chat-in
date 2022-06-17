import 'package:chatin/module_hive/index.dart';
import 'package:chatin/repositories/index.dart';
import 'package:chatin/repositories/personuser_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class StartApp {
  static Future<void> registers(BuildContext context,ENV enviroment) async {
    if(!GetIt.I.isRegistered(instance: ConfigRepository)) GetIt.I.registerSingleton<ConfigRepository>(ConfigRepository(enviroment: enviroment));
    if(!GetIt.I.isRegistered(instance: PersonUserRepository)) GetIt.I.registerSingleton<PersonUserRepository>(PersonUserRepository());
    if(!GetIt.I.isRegistered(instance: HiveController())) {
      GetIt.I.registerSingleton<HiveController>(HiveController());
      await GetIt.I.get<HiveController>().init();
    }
  }
}
