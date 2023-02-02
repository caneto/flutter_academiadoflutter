import '../../../cuidapet_api.dart';

class LoginRQ extends Serializable {

  String login;
  String senha;
  bool facebookLogin;
  String avatar;

  @override
  Map<String, dynamic> asMap() {
    return {
      'login' : login,
      'senha' : senha,
      'facebookLogin' : facebookLogin,
      'avatar' : avatar,
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    login = object['login'] as String;
    senha = object['senha'] as String;
    facebookLogin = object['facebookLogin'] as bool;
    avatar = object['avatar'] as String;
  }

}