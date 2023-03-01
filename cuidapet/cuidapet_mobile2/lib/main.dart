import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/core/app_config.dart';

Future<void> main() async {
  await const AppConfig().configureApp();
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
