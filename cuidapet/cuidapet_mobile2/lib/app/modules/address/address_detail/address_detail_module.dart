import 'package:flutter_modular/flutter_modular.dart';

import '../../../services/address/address_service.dart';
import 'address_detail_controller.dart';
import 'address_detail_page.dart';

class AddressDetailModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => AddressDetailController(addressService: i<AddressService>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => AddressDetailPage(place: args.data),
    ),
  ];
}
