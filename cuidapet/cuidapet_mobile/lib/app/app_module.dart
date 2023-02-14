import 'package:flutter_modular/flutter_modular.dart';

import 'modules/address/address_module.dart';
import 'modules/auth/auth_module.dart';
import 'modules/core/core_module.dart';
import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/auth', module: AuthModule()),
        ModuleRoute('/home', module: HomeModule()),
        ModuleRoute('/address', module: AddressModule()),
      ];

  @override
  List<Module> get imports => [CoreModule()];
}
