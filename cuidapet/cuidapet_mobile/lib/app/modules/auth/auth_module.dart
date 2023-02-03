import 'package:flutter_modular/flutter_modular.dart';

import '../core/core_module.dart';
import 'home/auth_home_page.dart';
import 'login/login_module.dart';

class AuthModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, __) => const AuthHomePage(),
    ),
    ModuleRoute('/login', module: LoginModule()),
  ];
}
