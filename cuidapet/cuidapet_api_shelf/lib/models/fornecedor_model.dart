import 'dart:convert';

import 'package:cuidapet_api/models/categorias_model.dart';

class FornecedorModel {
 
  FornecedorModel({
    this.id,
    this.nome,
    this.logo,
    this.endereco,
    this.telefone,
    this.latitude,
    this.longitude,
    this.categoria
  });

  

  int id;
  String nome;
  String logo;
  String endereco;
  String telefone;
  double latitude;
  double longitude;
  CategoriaModel categoria;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'logo': logo,
      'endereco': endereco,
      'telefone': telefone,
      'latitude': latitude,
      'longitude': longitude,
      'categoria': categoria?.toMap()
    };
  }
}
