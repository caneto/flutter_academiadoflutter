import 'package:cuidapet_api/cuidapet_api.dart';

class ChangePasswordRQ extends Serializable{
  String password;

  @override
  Map<String, dynamic> asMap() {
    return {
      'password' : password 
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    password = object['password'] as String;
  }
}