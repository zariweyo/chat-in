import 'package:chatin/module_hive/controllers/hive_controller.dart';
import 'package:chatin/repositories/config_repository.dart';
import 'package:chatin/repositories/personuser_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MockStartApp {

  static Future<void> registers(BuildContext context) async {
    GetIt.I.registerSingleton<ConfigRepository>(ConfigRepository(enviroment: ENV.test));
    GetIt.I.registerSingleton<PersonUserRepository>(PersonUserRepository());
    GetIt.I.registerSingleton<HiveController>(HiveController());
    await GetIt.I.get<HiveController>().initTest();
  }
}
