import 'package:json_annotation/json_annotation.dart';

part 'supplier_model.g.dart';

@JsonSerializable(createToJson: false)
class SupplierModel {
  final String name;
  final String logo;
  final String address;
  final String phone;
  final double? lat;
  final double? lng;
  @JsonKey(name: 'categorias_fornecedor_id', defaultValue: 0)
  final int supplierCategoryId;

  const SupplierModel({
    required this.name,
    required this.logo,
    required this.address,
    required this.phone,
    required this.lat,
    required this.lng,
    required this.supplierCategoryId,
  });

  factory SupplierModel.fromJson(Map<String, dynamic> map) =>
      _$SupplierModelFromJson(map);
}
