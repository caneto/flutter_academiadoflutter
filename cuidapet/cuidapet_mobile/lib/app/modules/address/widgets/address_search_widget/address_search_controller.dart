import 'package:mobx/mobx.dart';

import '../../../../models/place_model.dart';
import '../../../../services/address/address_service.dart';

part 'address_search_controller.g.dart';

class AddressSearchController = AddressSearchControllerBase
    with _$AddressSearchController;

abstract class AddressSearchControllerBase with Store {
  final AddressService _addressService;

  const AddressSearchControllerBase({required AddressService addressService})
      : _addressService = addressService;

  Future<List<PlaceModel>> searchAddress(String addressPattern) =>
      _addressService.findAddressByGooglePlace(addressPattern);
}
