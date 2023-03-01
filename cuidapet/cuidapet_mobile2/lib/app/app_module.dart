import 'package:flutter_modular/flutter_modular.dart';

import 'modules/address/address_module.dart';
import 'modules/auth/auth_module.dart';
import 'modules/core/core_module.dart';
import 'modules/home/home_module.dart';
import 'modules/schedules/schedules_module.dart';
import 'modules/supplier/supplier_module.dart';

class AppModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/auth', module: AuthModule()),
        ModuleRoute('/home', module: HomeModule()),
        ModuleRoute('/address', module: AddressModule()),
        ModuleRoute('/supplier', module: SupplierModule()),
        ModuleRoute('/schedules', module: SchedulesModule()),
      ];

  @override
  List<Module> get imports => [CoreModule()];
}
