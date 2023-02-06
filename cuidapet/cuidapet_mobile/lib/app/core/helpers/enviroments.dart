import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environments {
  const Environments._();

  static String? params(String paramName) => kReleaseMode
      ? FirebaseRemoteConfig.instance.getString(paramName)
      : dotenv.env[paramName];

  static Future<void> loadEnvs() async {
    if (kReleaseMode) {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(hours: 10),
        ),
      );
      await remoteConfig.fetchAndActivate();
    } else {
      await dotenv.load();
    }
  }
}
