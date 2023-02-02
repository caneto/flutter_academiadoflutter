import 'package:cuidapet_api/cuidapet_api.dart';

class SalvarFornecedorRequest extends Serializable {
  String nome;
  String logo;
  String endereco;
  String telefone;
  double latitude;
  double longitude;
  int categoria;
  String usuario;
  String senha;

  @override
  Map<String, dynamic> asMap() {
    return {
      'nome': nome,
      'logo': logo,
      'endereco': endereco,
      'telefone': telefone,
      'latitude': latitude,
      'longitude': longitude,
      'categoria': categoria,
      'usuario': usuario,
      'senha': senha
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    nome = object['nome'] as String;
    logo = object['logo'] as String;
    endereco = object['endereco'] as String;
    telefone = object['telefone'] as String;
    latitude = object['latitude'] as double;
    longitude = object['longitude'] as double;
    categoria = object['categoria'] as int;
    usuario = object[ 'usuario'] as String;
    senha = object[ 'senha'] as String;

  }
}
