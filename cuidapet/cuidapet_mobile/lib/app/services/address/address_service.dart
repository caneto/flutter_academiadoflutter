import '../../entities/address_entity.dart';
import '../../models/place_model.dart';

abstract class AddressService {
  Future<List<PlaceModel>> findAddressByGooglePlace(String addressPattern);
  Future<List<AddressEntity>> getAddress();
  Future<AddressEntity> saveAddress(PlaceModel place, String additionalAddress);
  Future<void> deleteAll();
  Future<void> selectAddress(AddressEntity address);
  Future<AddressEntity?> getSelectedAddress();
}
