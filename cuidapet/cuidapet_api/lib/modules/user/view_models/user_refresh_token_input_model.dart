import 'package:cuidapet_api/application/helpers/request_mapping.dart';

class UserRefreshTokenInputModel extends RequestMapping {
  int user;
  int? supplier;
  String accessToken;
  late String refreshToken;

  UserRefreshTokenInputModel({
    required this.user,
    this.supplier,
    required this.accessToken,
    required String dataRequest,
  }) : super(dataRequest);

  @override
  void map() {
    refreshToken = data['refresh_token'];
  }
}
