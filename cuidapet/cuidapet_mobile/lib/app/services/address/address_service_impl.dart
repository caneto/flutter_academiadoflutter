import '../../core/helpers/constants.dart';
import '../../core/local_storage/local_storage.dart';
import '../../entities/address_entity.dart';
import '../../models/place_model.dart';
import '../../repositories/address/address_repository.dart';
import './address_service.dart';

class AddressServiceImpl implements AddressService {
  final AddressRepository _addressRepository;
  final LocalStorage _localStorage;

  AddressServiceImpl({
    required AddressRepository addressRepository,
    required LocalStorage localStorage,
  })  : _addressRepository = addressRepository,
        _localStorage = localStorage;

  @override
  Future<List<PlaceModel>> findAddressByGooglePlace(
    String addressPattern,
  ) =>
      _addressRepository.findAddressByGooglePlace(addressPattern);

   @override
  Future<void> deleteAll() => _addressRepository.deleteAll();

  @override
  Future<List<AddressEntity>> getAddress() => _addressRepository.getAddress();

  @override
  Future<AddressEntity> saveAddress(
    PlaceModel place,
    String additionalInfo,
  ) async {
    final address = AddressEntity(
      address: place.address,
      lat: place.latitude,
      lng: place.longitude,
      additionalInfo: additionalInfo,
    );

    final addressId = await _addressRepository.saveAddress(address);

    return address.copyWith(id: addressId);
  }

    @override
  Future<AddressEntity?> getSelectedAddress() async {
    final jsonAddress = await _localStorage
        .read<String>(Constants.localStorageDefaultAddressDataKey);

    if (jsonAddress != null) {
      return AddressEntity.fromJson(jsonAddress);
    }

    return null;
  }

  @override
  Future<void> selectAddress(AddressEntity address) =>
      _localStorage.write<String>(
        Constants.localStorageDefaultAddressDataKey,
        address.toJson(),
      );

}
