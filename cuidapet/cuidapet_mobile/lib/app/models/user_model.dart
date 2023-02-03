import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  final String email;
  final String registerType;
  final String imgAvatar;

  const UserModel({
    required this.email,
    required this.registerType,
    required this.imgAvatar,
  });
 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'registerType': registerType,
      'imgAvatar': imgAvatar,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: (map["email"] ?? '') as String,
      registerType: (map["registerType"] ?? '') as String,
      imgAvatar: (map["imgAvatar"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(email: $email, registerType: $registerType, imgAvatar: $imgAvatar)';
}
