import 'package:cuidapet_api/cuidapet_api.dart';

class LoginCadastroRq extends Serializable {

  String email;
  String senha;


  @override
  Map<String, dynamic> asMap() {
    return {
      'email': email,
      'senha': senha
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    email = object['email'] as String;
    senha = object['senha'] as String;
  }

}
