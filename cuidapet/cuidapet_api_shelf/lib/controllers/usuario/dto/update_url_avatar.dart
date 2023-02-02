import 'package:cuidapet_api/cuidapet_api.dart';

class UpdateUrlAvatar extends Serializable {
  String urlAvatar;

  @override
  Map<String, dynamic> asMap() {
    return {
      'url_avatar' : urlAvatar
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    urlAvatar = object['url_avatar'] as String;
  }
}