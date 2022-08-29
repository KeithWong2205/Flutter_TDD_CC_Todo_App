import 'package:flutter_tcc_base_source/core/di/injection_container.dart';
import 'package:flutter_tcc_base_source/core/helpers/app_config.dart';
import 'package:flutter_tcc_base_source/core/helpers/app_utils.dart';
import 'package:flutter_tcc_base_source/core/helpers/global_configs.dart';
import 'package:flutter_tcc_base_source/core/helpers/secure_storage.dart';
import 'package:flutter_tcc_base_source/features/todo_management/domain/models/todo_model.dart';
import 'package:flutter_tcc_base_source/my_app.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  //Hive DB
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(TodoModelAdapter());
  await AppUtils.init();
  String firstTime = (await sl<SecureStorage>().getCustomString(SecureStorage.isFirstTime));
  String isLoggedIn = (await sl<SecureStorage>().getCustomString(SecureStorage.isLoggedIn));
  runApp(
    AppConfig(
      configUrl: GlobalConfig.configUrlRelease,
      buildFlavor: GlobalConfig.prod,
      child: MyApp(
        isFirstTime: firstTime.isEmpty,
        isLoggedIn: isLoggedIn.isNotEmpty,
      ),
    ),
  );
}
