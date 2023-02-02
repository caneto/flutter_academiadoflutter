
import 'package:cuidapet_api/models/fornecedor_model.dart';
import 'package:cuidapet_api/models/fornecedor_servicos_model.dart';
import 'package:cuidapet_api/models/usuario_model.dart';

class AgendamentoModel {
  
  AgendamentoModel({
    this.id,
    this.nome,
    this.nomePet,
    this.dataAgendamento,
    this.usuario,
    this.fornecedor,
    this.status,
    this.servicos
  });

  int id;
  String nome;
  String nomePet;
  DateTime dataAgendamento;
  UsuarioModel usuario;
  FornecedorModel fornecedor;
  String status;
  List<FornecedorServicosModel> servicos;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'nomePet': nomePet,
      'dataAgendamento': dataAgendamento?.toIso8601String(),
      'usuario': usuario?.toMap(),
      'fornecedor': fornecedor?.toMap(),
      'status': status,
      'servicos': servicos?.map((s) => s.toMap())?.toList(),
    };
  }

}
