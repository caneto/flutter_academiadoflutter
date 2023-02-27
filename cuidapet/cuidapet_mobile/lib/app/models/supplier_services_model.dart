import 'dart:convert';


class SupplierServicesModel {
  
  final int ind;
  final int supplierId;
  final String name;
  final double price;

  SupplierServicesModel({
    this.ind = 0,
    this.supplierId = 0,
    this.name = '',
    this.price = 0.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'ind': ind,
      'supplier_id': supplierId,
      'name': name,
      'price': price,
    };
  }

  factory SupplierServicesModel.fromMap(Map<String, dynamic> map) {
    return SupplierServicesModel(
      ind: map['ind']?.toInt() ?? 0,
      supplierId: map['supplier_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SupplierServicesModel.fromJson(String source) => SupplierServicesModel.fromMap(json.decode(source));
}
