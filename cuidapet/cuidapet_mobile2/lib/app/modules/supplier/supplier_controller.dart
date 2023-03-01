import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../core/life_cycle/controller_life_cycle.dart';
import '../../core/logger/app_logger.dart';
import '../../core/ui/widgets/loader.dart';
import '../../core/ui/widgets/messages.dart';
import '../../models/supplier_model.dart';
import '../../models/supplier_services_model.dart';
import '../../services/supplier/supplier_service.dart';
import '../schedules/model/schedule_view_model.dart';

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
  var _supplierServices = <SupplierServicesModel>[];

  @readonly
  // ignore: prefer_final_fields
  var _servicesSelected = <SupplierServicesModel>[].asObservable();

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

  @action
  void addOrRemoveService(SupplierServicesModel supplierServiceModel) {
    if (_servicesSelected.contains(supplierServiceModel)) {
      _servicesSelected.remove(supplierServiceModel);
    } else {
      _servicesSelected.add(supplierServiceModel);
    }
  }

  bool isServiceSelected(SupplierServicesModel serviceModel) =>
      _servicesSelected.contains(serviceModel);

  int get totalServicesSelected => _servicesSelected.length;    

  Future<void> goToPhoneOrCopyPhoneToClipart() async {
    final phoneUrl = 'tel:${_supplierModel?.phone}';

    if (await canLaunchUrlString(phoneUrl)) {
      await launchUrlString(phoneUrl);
    } else {
      await Clipboard.setData(ClipboardData(text: _supplierModel?.phone ?? ''));
      Messages.info('Telefone copiado');
    }
  }

  Future<void> gotoGeoOrCopyAddressToClipart() async {
    final geoUrl = 'geo:${_supplierModel?.lat}, ${_supplierModel?.lng}';

    if (await canLaunchUrlString(geoUrl)) {
      await launchUrlString(geoUrl);
    } else {
      await Clipboard.setData(
          ClipboardData(text: _supplierModel?.address ?? ''));
      Messages.info('Telefone copiado');
    }
  }

  void goToSchedule() {
    Modular.to.pushNamed(
      '/schedules/',
      arguments: ScheduleViewModel(
        supplierId: _supplierId,
        services: _supplierServices.toList(),
      ),
    );
  }
}
