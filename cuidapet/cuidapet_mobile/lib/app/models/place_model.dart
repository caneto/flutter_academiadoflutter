// ignore_for_file: public_member_api_docs, sort_constructors_first
class PlaceModel {
  final String address;
  final double latitude;
  final double longitude;

  const PlaceModel({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() => 'PlaceModel(address: $address, latitude: $latitude, longitude: $longitude)';
}
