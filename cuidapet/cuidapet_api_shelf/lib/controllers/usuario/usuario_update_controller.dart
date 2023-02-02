import 'package:cuidapet_api/controllers/usuario/dto/update_token_rq.dart';
import 'package:cuidapet_api/controllers/usuario/dto/update_url_avatar.dart';
import 'package:cuidapet_api/models/usuario_model.dart';
import 'package:cuidapet_api/repositories/usuario_repository.dart';

import '../../cuidapet_api.dart';

class UsuarioUpdateController extends ResourceController {
  
  final _repository = UsuarioRepository();

  @Operation.put()
  Future<Response> updateToken(@Bind.body() UpdateToken requestToken) async {
    final user = request.attachments['user'] as UsuarioModel;
    await _repository.updateDeviceToken(user.id, requestToken.token, requestToken.platform);
    return Response.ok({});
  }

}
