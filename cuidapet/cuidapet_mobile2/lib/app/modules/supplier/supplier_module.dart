import 'package:flutter_modular/flutter_modular.dart';

import '../core/supplier/supplier_core_module.dart';
import 'supplier_controller.dart';
import 'supplier_page.dart';

class SupplierModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => SupplierController(
        supplierService: i(),
        log: i(),  // CoreModule
      ),
    ),
  ];

  @override
  List<Module> get imports => [SupplierCoreModule()];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute('/', child: (context, args) => SupplierPage(supplierId: args.data))];
}
