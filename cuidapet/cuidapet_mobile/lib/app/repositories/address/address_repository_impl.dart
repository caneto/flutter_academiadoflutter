import 'package:google_place/google_place.dart';

import '../../core/database/sqlite_connection_factory.dart';
import '../../core/exceptions/failure.dart';
import '../../core/helpers/enviroments.dart';
import '../../entities/address_entity.dart';
import '../../models/place_model.dart';
import './address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
 
  final SqliteConnectionFactory _connectionFactory;

  const AddressRepositoryImpl({
    required SqliteConnectionFactory connectionFactory,
  }) : _connectionFactory = connectionFactory;


  @override
  Future<List<PlaceModel>> findAddressByGooglePlace(
    String addressPattern,
  ) async {
    final googleApiKey = Environments.params('google_api_key');

    if (googleApiKey == null) {
      throw const Failure(message: 'Google API Key not found');
    }

    final googlePlace = GooglePlace(googleApiKey);

    final addressResult =
        await googlePlace.search.getTextSearch(addressPattern);
    final candidates = addressResult?.results;

    if (candidates != null) {
      return candidates.map<PlaceModel>((e) {
        final location = e.geometry?.location;
        final address = e.formattedAddress;

        return PlaceModel(
          address: address ?? '',
          latitude: location?.lat ?? 0,
          longitude: location?.lng ?? 0,
        );
      }).toList();
    }

    return const [];
  }


  @override
  Future<void> deleteAll() async {
    final connection = await _connectionFactory.openConnection();

    await connection.delete('address');
  }

  @override
  Future<List<AddressEntity>> getAddress() async {
    final connection = await _connectionFactory.openConnection();

    final result = await connection.rawQuery('SELECT * FROM address');

    return result.map<AddressEntity>(AddressEntity.fromMap).toList();
  }

  @override
  Future<int> saveAddress(AddressEntity address) async {
    final connection = await _connectionFactory.openConnection();

    return connection.rawInsert('INSERT INTO address VALUES (?, ?, ?, ?, ?)', [
      null,
      address.address,
      address.lat,
      address.lng,
      address.additionalInfo,
    ]);
  }

}
