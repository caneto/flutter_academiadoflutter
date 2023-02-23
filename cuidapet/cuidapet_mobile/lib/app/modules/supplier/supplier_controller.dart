import 'package:mobx/mobx.dart';

import '../../core/life_cycle/controller_life_cycle.dart';
import '../../core/ui/widgets/loader.dart';
import '../../models/supplier_model.dart';
import '../../services/supplier/supplier_service.dart';

part 'supplier_controller.g.dart';

class SupplierController = SupplierControllerBase with _$SupplierController;

abstract class SupplierControllerBase with Store, ControllerLifeCycle {
  final SupplierService _service;

  SupplierControllerBase({required SupplierService service})
      : _service = service;

  var _supplierId = 0;

  @readonly
  SupplierModel? _supplierModel;

  @override
  void onInit([Map<String, dynamic>? params]) {
    super.onInit(params);
    _supplierId = params!['id'];
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    Loader.show();
    final suppliers = await _service.getSupplierById(_supplierId);
    _supplierModel = suppliers;
    Loader.hide();
  }
}
