
class CategoriaModel {
  
  CategoriaModel({
    this.id,
    this.nome,
    this.tipo,
  });

  int id;
  String nome;
  String tipo;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'tipo': tipo,
    };
  }

}
