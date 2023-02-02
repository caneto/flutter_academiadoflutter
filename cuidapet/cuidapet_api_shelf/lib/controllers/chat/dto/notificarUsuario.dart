
import 'package:cuidapet_api/cuidapet_api.dart';

class NotificarUsuarioRequest extends Serializable {

  int chat;
  String mensagem;
  String para;

  @override
  Map<String, dynamic> asMap() {
    return {
      'chat': chat,
      'mensagem': mensagem,
      'para': para
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    chat = object['chat'] as int;
    mensagem = object['mensagem'] as String;
    para = object['para'] as String;
  }




}