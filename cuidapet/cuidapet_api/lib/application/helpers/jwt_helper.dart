import 'package:cuidapet_api/application/config/application_config.dart';
import 'package:get_it/get_it.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

final env = GetIt.I.get<ApplicationConfig>().env;
class JwtHelper {
  static final String _jwtSecret = env['JWT_SECRET'] ?? env['jwtSecret']!;

  JwtHelper._();

  static String generateJWT(int userId, int? supplierId) {

    final expire = int.parse(env['JWT_EXPIRE'] ?? env['jwtExpire']!);

    final claimSet = JwtClaim(
        issuer: 'cuidapet',
        subject: userId.toString(),
        expiry: DateTime.now().add(Duration(days: expire)),
        notBefore: DateTime.now(),
        issuedAt: DateTime.now(),
        otherClaims: <String, dynamic>{'supplier': supplierId},
        maxAge: Duration(days: expire));

    return 'Bearer ${issueJwtHS256(claimSet, _jwtSecret)}';
  }

  static JwtClaim getClaims(String token) {
    return verifyJwtHS256Signature(token, _jwtSecret);
  }

  static String refreshToken(String accessToken) {
    final env = GetIt.I.get<ApplicationConfig>().env;
    final expiry = int.parse(env['REFRESH_TOKEN_EXPIRE_DAYS'] ?? env['refresh_token_expire_days']!);
    final notBefore = int.parse(env['REFRESH_TOKEN_NOT_BEFORE_HOURS'] ?? env['refresh_token_not_before_hours']!);

    final claimSet = JwtClaim(
      issuer: accessToken,
      subject: 'RefreshToken',
      expiry: DateTime.now().add(Duration(days: expiry)),
      notBefore: DateTime.now().add(Duration(hours: notBefore)),
      issuedAt: DateTime.now(),
      otherClaims: <String, dynamic>{},
    );

    return 'Bearer ${issueJwtHS256(claimSet, _jwtSecret)}';
  }
}
