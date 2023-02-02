

class UsuarioModel {
  
  UsuarioModel({
    this.id,
    this.email,
    this.tipoCadastro,
    this.iosToken,
    this.androidToken,
    this.refrehToken,
    this.imgAvatar,
    this.fornecedorId,
  });

  int id;
  String email;
  String tipoCadastro;
  String iosToken;
  String androidToken;
  String refrehToken;
  String imgAvatar;
  int fornecedorId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'tipoCadastro': tipoCadastro,
      'iosToken': iosToken,
      'androidToken': androidToken,
      'refrehToken': refrehToken,
      'imgAvatar': imgAvatar,
      'fornecedorId': fornecedorId
    };
  }
}
