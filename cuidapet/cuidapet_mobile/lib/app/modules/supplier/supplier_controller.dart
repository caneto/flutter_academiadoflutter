import 'package:mobx/mobx.dart';

import '../../core/life_cycle/controller_life_cycle.dart';
import '../../core/logger/app_logger.dart';
import '../../core/ui/widgets/loader.dart';
import '../../core/ui/widgets/messages.dart';
import '../../models/supplier_model.dart';
import '../../models/supplier_service_model.dart';
import '../../services/supplier/supplier_service.dart';

part 'supplier_controller.g.dart';

class SupplierController = SupplierControllerBase with _$SupplierController;

abstract class SupplierControllerBase with Store, ControllerLifeCycle {
  final SupplierService _supplierService;
  final AppLogger _log;

  SupplierControllerBase({
    required SupplierService supplierService,
    required AppLogger log,
  })  : _supplierService = supplierService,
        _log = log;

  var _supplierId = 0;

  @readonly
  SupplierModel? _supplierModel;

  @readonly
  var _supplierServices = <SupplierServiceModel>[];

  @override
  void onInit([Map<String, dynamic>? params]) {
    super.onInit(params);
    _supplierId = params!['supplierId'] ?? 0;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    try {
      Loader.show();
      await Future.wait([_getSuppierById(), _getSupplierService()]);
    } finally {
      Loader.hide();
    }

    // _supplierModel = suppliers;
    
  }

  @action
  Future<void> _getSuppierById() async {
    try {
      _supplierModel = await _supplierService.getSupplierById(_supplierId);
    } catch (e, s) {
      _log.error('Erro ao buscar dados do fornecedor', e, s);
      Messages.alert('Erro ao buscar dados do fornecedor');
    }
  }

  @action
  Future<void> _getSupplierService() async {
    try {
      _supplierServices = await _supplierService.getServices(_supplierId);
    } catch (e, s) {
      _log.error('Erro ao buscar dados dos servicos do fornecedor', e, s);
      Messages.alert('Erro ao buscar dados dos servicos do fornecedor');
    }
  }
}
