
class FornecedorServicosModel {
  
  FornecedorServicosModel({
    this.id,
    this.fornecedorId,
    this.nome,
    this.valor,
  });

  int id;
  int fornecedorId;
  String nome;
  double valor;
  

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fornecedorId': fornecedorId,
      'nome': nome,
      'valor': valor,
    };
  }
}
