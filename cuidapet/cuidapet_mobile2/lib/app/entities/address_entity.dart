import 'dart:convert';

class AddressEntity {
  final int? id;
  final String address;
  final double lat;
  final double lng;
  final String additionalInfo;

  const AddressEntity({
    required this.address,
    required this.lat,
    required this.lng,
    required this.additionalInfo,
    this.id,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'address': address,
        'lat': lat.toString(),
        'lng': lng.toString(),
        'additionalInfo': additionalInfo,
      };

  factory AddressEntity.fromMap(Map<String, dynamic> map) => AddressEntity(
        id: map['id']?.toInt(),
        address: map['address'] ?? '',
        lat: double.parse(map['lat'] ?? '0.0'),
        lng: double.parse(map['lng'] ?? '0.0'),
        additionalInfo: map['additionalInfo'] ?? '',
      );

  String toJson() => jsonEncode(toMap());

  factory AddressEntity.fromJson(String source) =>
      AddressEntity.fromMap(jsonDecode(source));

  AddressEntity copyWith({
    int? id,
    String? address,
    double? lat,
    double? lng,
    String? additionalInfo,
  }) =>
      AddressEntity(
        id: id ?? this.id,
        address: address ?? this.address,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        additionalInfo: additionalInfo ?? this.additionalInfo,
      );
}
