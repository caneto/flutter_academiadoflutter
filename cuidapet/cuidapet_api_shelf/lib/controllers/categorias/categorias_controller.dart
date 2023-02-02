import 'package:cuidapet_api/repositories/categorias_repository.dart';

import '../../cuidapet_api.dart';

class CategoriasController extends ResourceController {
  final _repository = CategoriasRepository();

  @Operation.get()
  Future<Response> buscarTodasCategorias() async {
    try {
      final categorias = await _repository.findAll();
      return Response.ok(categorias.map((e) => e.toMap()).toList());
    } catch (e) {
      print(e);
      return Response.serverError(body: {'mensagem': 'Erro ao buscar categorias'});
    }
  }
}
