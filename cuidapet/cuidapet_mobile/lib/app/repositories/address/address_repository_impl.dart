import 'package:google_place/google_place.dart';

import '../../core/exceptions/failure.dart';
import '../../core/helpers/enviroments.dart';
import '../../models/place_model.dart';
import './address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
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
}
