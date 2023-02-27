import 'package:flutter_modular/flutter_modular.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';

import '../../core/life_cycle/controller_life_cycle.dart';
import '../../core/ui/widgets/loader.dart';
import '../../core/ui/widgets/messages.dart';
import '../../entities/address_entity.dart';
import '../../models/place_model.dart';
import '../../services/address/address_service.dart';

part 'address_controller.g.dart';

class AddressController = AddressControllerBase with _$AddressController;

abstract class AddressControllerBase with Store, ControllerLifeCycle {
  final AddressService _addressService;

  AddressControllerBase({required AddressService addressService})
      : _addressService = addressService;

  @override
  void onReady() {
    getAddresses();
  }

  @readonly
  var _addresses = const <AddressEntity>[];

  @readonly
  var _locationServiceUnavailable = false;

  @readonly
  LocationPermission? _locationPermission;

  @readonly
  PlaceModel? _placeModel;

  @action
  Future<void> getAddresses() async {
    Loader.show();
    _addresses = await _addressService.getAddress();
    Loader.hide();
  }

  @action
  Future<void> getMyLocation() async {
    _locationPermission = null;
    _locationServiceUnavailable = false;

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      _locationServiceUnavailable = true;
      return;
    }

    final locationPermission = await Geolocator.checkPermission();

    switch (locationPermission) {
      case LocationPermission.denied:
        final permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          _locationPermission = permission;
          return;
        }
        break;
      case LocationPermission.deniedForever:
        _locationPermission = locationPermission;
        return;
      case LocationPermission.whileInUse:
      case LocationPermission.always:
      case LocationPermission.unableToDetermine:
        break;
    }

    Loader.show();

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    final place = placemark.first;
    final address = '${place.thoroughfare} ${place.subThoroughfare}';

    final placeModel = PlaceModel(
      address: address,
      latitude: position.latitude,
      longitude: position.longitude,
    );

    Loader.hide();
    goToAddressDetail(placeModel);
  }

  Future<void> goToAddressDetail(PlaceModel place) async {
    final address =
        await Modular.to.pushNamed('/address/detail/', arguments: place);

    // User is editing an address
    if (address is PlaceModel) {
      _placeModel = address;
    }
    // User saved an address
    else if (address is AddressEntity) {
      selectAddress(address);
    }
  }

  Future<void> selectAddress(AddressEntity address) async {
    await _addressService.selectAddress(address);
    Modular.to.pop<AddressEntity>(address);
  }

  Future<bool> wasAddressSelected() async {
     final address = await _addressService.getSelectedAddress();

    if (address != null) {
       return true;
     } else {
       Messages.alert('Selecione ou cadastre um endereço!');

       return false;
     }
  }

}
