
import 'package:cuidapet_api/entities/device_token.dart';
import 'package:cuidapet_api/entities/supplier.dart';

class Chat {
  final int id;
  final int user;
  final Supplier supplier;
  final String name;
  final String petName;
  final String status;
  final DeviceToken? userDeviceToken;
  final DeviceToken? supplierDeviceToken;
  
  Chat({
    required this.id,
    required this.user,
    required this.supplier,
    required this.name,
    required this.petName,
    required this.status,
    this.userDeviceToken,
    this.supplierDeviceToken,
  });

}
