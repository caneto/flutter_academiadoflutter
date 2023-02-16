import 'package:flutter_modular/flutter_modular.dart';

import '../../services/address/address_service.dart';
import 'address_controller.dart';
import 'address_detail/address_detail_module.dart';
import 'address_page.dart';
import 'widgets/address_search_widget/address_search_controller.dart';

class AddressModule extends Module {

   @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => AddressSearchController(addressService: i<AddressService>()),
    ),
    Bind.lazySingleton((i) => AddressController(addressService: i())),
  ];

   @override
   final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_,__) => const AddressPage()),
    ModuleRoute('/detail', module: AddressDetailModule()),
   ];

}
