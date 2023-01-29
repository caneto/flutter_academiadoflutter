import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ContactModel {
  final String? id;
  final String name;
  final String email;
  
  const ContactModel({
    this.id,
    required this.name,
    required this.email,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'],
      name: (map["name"] ?? '') as String,
      email: (map["email"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) => ContactModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
