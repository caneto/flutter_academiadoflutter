import '../../entities/address_entity.dart';
import '../../models/place_model.dart';

abstract class AddressRepository {
  Future<List<PlaceModel>> findAddressByGooglePlace(String addressPattern);
  Future<List<AddressEntity>> getAddress();
  Future<int> saveAddress(AddressEntity address);
  Future<void> deleteAll();
}
