import 'package:cuidapet_api/cuidapet_api.dart';

class AgendarServicoRQ extends Serializable{

  DateTime dataAgendamento;
  int fornecedorId;
  List<int> servicos;
  String nome;
  String nomePet;



  @override
  Map<String, dynamic> asMap() {
    return {
      'data_agendamento': dataAgendamento,
      'fornecedor_id': fornecedorId,
      'servicos': servicos,
      'nome': nome,
      'nomePet': nomePet
    };
  }

  @override
  void readFromMap(Map<String,dynamic> object) {
    dataAgendamento = DateTime.parse(object['data_agendamento'] as String);
    fornecedorId = object['fornecedor_id'] as int;
    servicos = List.castFrom<dynamic, int>(object['servicos'] as List);
    nome = object['nome'] as String;
    nomePet = object['nome_pet'] as String;
  }


}