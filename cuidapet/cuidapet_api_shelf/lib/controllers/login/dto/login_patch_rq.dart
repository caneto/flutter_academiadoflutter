import 'package:cuidapet_api/cuidapet_api.dart';

class LoginPatchRq extends Serializable {
  String iosToken;
  String androidToken;

  @override
  Map<String, dynamic> asMap() {
    return {
      'iosToken': iosToken,
      'androidToken': androidToken,
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    iosToken = object['ios_token'] as String;
    androidToken = object['android_token'] as String;
  }
}
