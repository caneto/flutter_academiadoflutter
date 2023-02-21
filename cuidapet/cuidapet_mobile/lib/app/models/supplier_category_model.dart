import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'supplier_category_model.g.dart';

@JsonSerializable(createToJson: false)
class SupplierCategoryModel extends Equatable {
  final int id;
  final String name;
  final String type;

  const SupplierCategoryModel({
    required this.id,
    required this.name,
    required this.type,
  });

  factory SupplierCategoryModel.fromJson(Map<String, dynamic> map) =>
      _$SupplierCategoryModelFromJson(map);

  @override
  List<Object?> get props => [id, name, type];
}
