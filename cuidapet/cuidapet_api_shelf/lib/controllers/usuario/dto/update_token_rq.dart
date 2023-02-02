import 'package:cuidapet_api/cuidapet_api.dart';

class UpdateToken extends Serializable{
  String token;
  String platform;

  @override
  Map<String, dynamic> asMap() {
    return {
      'token': token,
      'platform': platform
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    token = object['token'] as String;
    platform = object['platform'] as String;
  }
}