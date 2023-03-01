import 'package:flutter_modular/flutter_modular.dart';

import '../../../repositories/supplier/supplier_repository.dart';
import '../../../repositories/supplier/supplier_repository_impl.dart';
import '../../../services/supplier/supplier_service.dart';
import '../../../services/supplier/supplier_service_impl.dart';

class SupplierCoreModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton<SupplierRepository>(
          (i) => SupplierRepositoryImpl(restClient: i(), logger: i()),
          export: true,
        ),
        Bind.lazySingleton<SupplierService>(
          (i) => SupplierServiceImpl(repository: i()),
          export: true,
        ),
      ];
}
