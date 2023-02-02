import 'package:cuidapet_api/exceptions/user_notfound_exception.dart';
import 'package:cuidapet_api/repositories/usuario_repository.dart';
import 'package:cuidapet_api/utils/jwt_utils.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

import '../cuidapet_api.dart';

class JwtAuthenticationMiddleware extends Controller {

  @override
  FutureOr<RequestOrResponse> handle(Request request) async {
    
    // Recuperando o header
    final authHeader = request.raw.headers["authorization"];
    if (authHeader == null || authHeader.isEmpty) {
      return Response.unauthorized();
    }

    final authHeaderContent = authHeader[0]?.split(" ");

    if (authHeaderContent.length != 2 || authHeaderContent[0] != "Bearer") {
      return Response.badRequest(body: {'message': 'invalid token'});
    }

    try {
      final token = authHeaderContent[1];
      final JwtClaim decClaimSet = JwtUtils.getClaims(token);
      decClaimSet.validate();

      // sub = subject
      final userId = int.parse(decClaimSet.toJson()["sub"].toString());
      // print(userId);
      print(decClaimSet.toJson().toString());

      if (userId == null) {
        throw JwtException.invalidToken;
      }
      //Validar se usuário existe
      final user = await UsuarioRepository().getById(userId);


      if (user == null) {
        return Response.unauthorized();
      }

      request.attachments['user'] = user;
      request.attachments['access_token'] = token;

      return request;
    } on JwtException catch (e) {
      print(e);
      return Response.unauthorized();
    } on UserNotFoundException catch(e) {
      print(e);
      return Response.unauthorized();
    }
  }
}
