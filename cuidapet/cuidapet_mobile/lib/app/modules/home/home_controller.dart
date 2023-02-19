import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/life_cycle/controller_life_cycle.dart';
import '../../core/ui/widgets/loader.dart';
import '../../core/ui/widgets/messages.dart';
import '../../entities/address_entity.dart';
import '../../services/address/address_service.dart';
part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store, ControllerLifeCycle {
  final AddressService _addressService;

  @readonly
  AddressEntity? _addressEntity;

  HomeControllerBase({
    required AddressService addressService,
    //required SupplierService supplierService,
  })  : _addressService = addressService;
        //_supplierService = supplierService;

  
  @override
  Future<void> onReady() async {
    try {
      super.onReady();
      Loader.show();
      await Future.wait([getSelectedAddress(), _getCategories()]);
      if (_addressEntity != null) {
        //await _supplierService.getSuppliersNearbyMe(_addressEntity!);
      }
    } finally {
      Loader.hide();
    }
  }

  @action
  Future<void> getSelectedAddress() async {
    _addressEntity ??= await _addressService.getSelectedAddress();

    if (_addressEntity == null) {
      await goToAddress();
    }
  }

  @action
  Future<void> goToAddress() async {
    final address = await Modular.to.pushNamed<AddressEntity>('/address/');
    if (address != null) {
      _addressEntity = address;
    }
  }

   @action
  Future<void> _getCategories() async {
    try {
      //final categories = await _supplierService.getCategories();
      //_categories = [...categories];
    } catch (e, s) {
      Messages.alert('Erro ao carregar categorias');

      Error.throwWithStackTrace(e, s);
    }
  }

}
