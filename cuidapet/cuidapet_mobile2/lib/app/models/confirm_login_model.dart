import 'package:json_annotation/json_annotation.dart';

part 'confirm_login_model.g.dart';

@JsonSerializable(createToJson: false)
class ConfirmLoginModel {
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  const ConfirmLoginModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory ConfirmLoginModel.fromJson(Map<String, dynamic> map) =>
      _$ConfirmLoginModelFromJson(map);
}
