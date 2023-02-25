// ignore_for_file: pu

import 'dart:convert';

import 'supplier_category_model.dart';

class SupplierModel {
  final int id;
  final String name;
  final String logo;
  final String address;
  final String phone;
  final double? lat;
  final double? lng;
  final SupplierCategoryModel category;

  const SupplierModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.address,
    required this.phone,
    required this.lat,
    required this.lng,
    required this.category,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'address': address,
      'phone': phone,
      'latitude': lat,
      'longitude': lng,
      'category': category.toMap(),
    };
  }

  factory SupplierModel.fromMap(Map<String, dynamic> map) {
    return SupplierModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      logo: map['logo'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      lat: map['latitude']?.toDouble(),
      lng: map['longitude']?.toDouble(),
      category: SupplierCategoryModel.fromMap(map['category']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SupplierModel.fromJson(String source) => SupplierModel.fromMap(json.decode(source));
}
