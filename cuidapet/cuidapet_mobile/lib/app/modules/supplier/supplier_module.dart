
import 'package:flutter_modular/flutter_modular.dart';

import 'supplier_page.dart';

class SupplierModule extends Module {
  
  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const SupplierPage())
  ];

}
