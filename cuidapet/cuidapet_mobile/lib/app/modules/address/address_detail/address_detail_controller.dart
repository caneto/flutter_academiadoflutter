import 'package:mobx/mobx.dart';

import '../../../core/life_cycle/controller_life_cycle.dart';
import '../../../core/ui/widgets/loader.dart';
import '../../../entities/address_entity.dart';
import '../../../models/place_model.dart';
import '../../../services/address/address_service.dart';

part 'address_detail_controller.g.dart';

class AddressDetailController = AddressDetailControllerBase
    with _$AddressDetailController;

abstract class AddressDetailControllerBase with Store, ControllerLifeCycle {
  final AddressService _addressService;

  @readonly
  AddressEntity? _address;

  AddressDetailControllerBase({required AddressService addressService})
      : _addressService = addressService;

  Future<void> saveAddress(PlaceModel place, String additionalInfo) async {
    Loader.show();
    final address = await _addressService.saveAddress(place, additionalInfo);

    Loader.hide();
    _address = address;
  }
}
