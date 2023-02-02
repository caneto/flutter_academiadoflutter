import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class JwtUtils {
  static const String _jwtPrivateKey = 'DuGru4jQvUMxP9eyTvDxwpBJhhMTnCXU8cG8YYu8g4jhpRermB5jHSk';

  static String generateJWT(int usuarioId) {
    final claimSet = JwtClaim(
      issuer: "http://localhost",
      subject: usuarioId.toString(),
      expiry: DateTime.now().add(const Duration(days: 1)),
      notBefore: DateTime.now(),
      issuedAt: DateTime.now(),
      otherClaims: <String, dynamic>{},
      maxAge: const Duration(days: 1),
    );

    final token = "Bearer ${issueJwtHS256(claimSet, _jwtPrivateKey)}";
    
    return token;
  }

  static String refreshToken(String accessToken) {
    final claimSet = JwtClaim(
      issuer: accessToken,
      subject: 'RefreshToken',
      expiry: DateTime.now().add(const Duration(days: 365)),
      notBefore: DateTime.now().subtract(const Duration(days: 1)),
      issuedAt: DateTime.now(),
      otherClaims: <String, dynamic>{},
    );

    final token = "Bearer ${issueJwtHS256(claimSet, _jwtPrivateKey)}";
    
    return token;
  }

  static String generateSHA256Hash(String password) {
    final bytes = utf8.encode(password);
    final passwordHash = sha256.convert(bytes).toString();
    return passwordHash;
  }

  static JwtClaim getClaims(String token) {
    return verifyJwtHS256Signature(token, _jwtPrivateKey);
  }
}
