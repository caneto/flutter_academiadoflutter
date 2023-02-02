import 'package:cuidapet_api/cuidapet_api.dart';

class RefreshTokenRQ extends Serializable{
  String token;
  String refreshToken;

  @override
  Map<String, dynamic> asMap() {
    return {
      'token' : token,
      'refreshToken': refreshToken
    };
  }

  @override
  void readFromMap(Map<String, dynamic>  object) {
    token = object['token'] as String;
    refreshToken = object['refresh_token'] as String;
  }
}