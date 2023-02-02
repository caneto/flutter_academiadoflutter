import 'package:cuidapet_api/repositories/fornecedores_repository.dart';

import '../../cuidapet_api.dart';
import 'dto/salvar_fornecedor_request.dart';

class FornecedorController extends ResourceController {
  
  final _repository = FornecedoresRepository();

  @Operation.get()
  Future<Response> buscarFornecedorProximos(@Bind.query('lat') double lat, @Bind.query('long') double long) async {
    try {
      final fornecedores = await _repository.buscarFornecedoresProximo(lat, long, 5);
      return Response.ok(fornecedores);
    } catch (e,s) {
      print(e);
      print(s);
      return Response.serverError(body: {'mensagem': 'Erro ao buscar fornecedores proximos'});
    }
  }
  
  @Operation.get('id')
  Future<Response> recuperarFornecedor(@Bind.path('id') int id) async {
    try {
      final fornecedor = await _repository.recuperarPorId(id);
      return Response.ok(fornecedor.toMap());
    } catch (e,s) {
      print(e);
      print(s);
      return Response.serverError(body: {'mensagem': 'Erro ao Fornecedor por id'});
    }
  }
  
  @Operation.get('fornecedorId')
  Future<Response> recuperarServicosFornecedor(@Bind.path('fornecedorId') int id) async {
    try {
      final fornecedor = await _repository.buscarTodosServicos(id);
      return Response.ok(fornecedor.map((s) => s.toMap()).toList());
    } catch (e,s) {
      print(e);
      print(s);
      return Response.serverError(body: {'mensagem': 'Erro ao buscar serviços do fornecedor'});
    }
  }

  @Operation.post()
  Future<Response> salvarFornecedor(@Bind.body() SalvarFornecedorRequest salvarFornecedor) async {
    try {
      await _repository.criarFornecedor(salvarFornecedor);
    return Response.ok({});

    } catch (e, s) {
      print(e);
      print(s);
      return Response.serverError(body: {'mensagem': 'Erro ao salvar fornecedor'});
    }
  }
}