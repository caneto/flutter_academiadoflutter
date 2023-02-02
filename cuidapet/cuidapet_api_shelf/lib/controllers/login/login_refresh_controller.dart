import 'package:cuidapet_api/controllers/login/dto/refresh_token_rq.dart';
import 'package:cuidapet_api/repositories/usuario_repository.dart';
import 'package:cuidapet_api/utils/jwt_utils.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

import '../../cuidapet_api.dart';

class LoginRefreshController extends ResourceController {
  final _repository = UsuarioRepository();

  @Operation.put()
  Future<Response> refreshToken(@Bind.body() RefreshTokenRQ refreshTokenRQ) async {
    try {
      final token = refreshTokenRQ.token?.split(" ");
      final refreshToken = refreshTokenRQ.refreshToken?.split(" ");

      if (token.length != 2 || token[0] != "Bearer") {
        return Response.badRequest(body: {'message': 'invalid token'});
      } else if (refreshToken?.length != 2 || refreshToken[0] != "Bearer") {
        return Response.badRequest(body: {'message': 'invalid refreshToken'});
      }
      final JwtClaim refrehtokenClaim = JwtUtils.getClaims(refreshToken[1]);
      refrehtokenClaim.validate(issuer: token[1]);

      final JwtClaim tokenClaim = JwtUtils.getClaims(token[1]);
      final userId = int.parse(tokenClaim.toJson()["sub"].toString());

      final newAccessToken = JwtUtils.generateJWT(userId);
      final newRefreshToken = JwtUtils.refreshToken(newAccessToken.split(' ')[1]);

      await _repository.updateRefreshToken(userId, newRefreshToken);

      return Response.ok({'access_token': newAccessToken, 'refresh_token': newRefreshToken});
    } on JwtException catch (e, s) {
      print(e);
      print(s);
      return Response.serverError(body: {'message': 'token inválido'});
    } catch (e, s) {
      print(e);
      print(s);
      return Response.serverError(body: {'message': 'Erro ao renovar token'});
    }
  }
}
