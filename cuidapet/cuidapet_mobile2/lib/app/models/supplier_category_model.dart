// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
    };
  }

  factory SupplierCategoryModel.fromMap(Map<String, dynamic> map) {
    return SupplierCategoryModel(
      id: (map['id'] ?? 0) as int,
      name: (map['name'] ?? '') as String,
      type: (map['type'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  //factory SupplierCategoryModel.fromJson(String source) => SupplierCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
