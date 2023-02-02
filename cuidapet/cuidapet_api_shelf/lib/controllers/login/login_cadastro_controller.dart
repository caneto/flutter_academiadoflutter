import 'package:cuidapet_api/controllers/login/dto/login_cadastro_rq.dart';
import 'package:cuidapet_api/cuidapet_api.dart';
import 'package:cuidapet_api/repositories/usuario_repository.dart';

class LoginCadastroController extends ResourceController {

  final UsuarioRepository _repository = UsuarioRepository();


  @Operation.post()
  Future<Response> cadastro(@Bind.body() LoginCadastroRq rq) async {
    await _repository.createUser(rq.email, rq.senha);
    return Response.ok({'message': 'cadastrado com sucesso'});
  }


}