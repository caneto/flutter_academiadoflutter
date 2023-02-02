import 'dart:convert';
import 'package:crypto/crypto.dart';

class CriptyUtils {
  static String generateSHA256Hash(String password) {
    final bytes = utf8.encode(password);
    final passwordHash = sha256.convert(bytes).toString();

    return passwordHash;
  }
}
