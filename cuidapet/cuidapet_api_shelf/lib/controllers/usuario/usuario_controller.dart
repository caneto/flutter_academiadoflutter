import 'package:cuidapet_api/controllers/usuario/dto/update_token_rq.dart';
import 'package:cuidapet_api/controllers/usuario/dto/update_url_avatar.dart';
import 'package:cuidapet_api/models/usuario_model.dart';
import 'package:cuidapet_api/repositories/usuario_repository.dart';

import '../../cuidapet_api.dart';

class UsuarioController extends ResourceController {
  final _repository = UsuarioRepository();

  @Operation.get()
  Future<Response> findById() async {
    final user = request.attachments['user'] as UsuarioModel;
    final usuario = await _repository.getById(user.id);
    return Response.ok({
      'email': usuario.email,
      'tipoCadastro': usuario.tipoCadastro,
      'imgAvatar': usuario.imgAvatar,
    });
  }

  @Operation.put()
  Future<Response> updateUrlAvatar(@Bind.body() UpdateUrlAvatar requestAvatar) async {
    final user = request.attachments['user'] as UsuarioModel;
    await _repository.updateImage(user.id, requestAvatar.urlAvatar);
    final usuario = await _repository.getById(user.id);
    return Response.ok({
      'email': usuario.email,
      'tipoCadastro': usuario.tipoCadastro,
      'imgAvatar': usuario.imgAvatar,
    });
  }

}
