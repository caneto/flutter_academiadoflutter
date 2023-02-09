import 'package:flutter_modular/flutter_modular.dart';

import '../../core/local_storage/flutter_secure_storage/flutter_secure_storage_local_storage_impl.dart';
import '../../core/local_storage/local_storage.dart';
import '../../core/local_storage/shared_preferences/shared_preferences_local_storage_impl.dart';
import '../../core/logger/app_logger.dart';
import '../../core/logger/app_logger_impl.dart';
import '../../core/rest_client/dio/dio_rest_client.dart';
import '../../core/rest_client/rest_client.dart';
import 'auth/auth_store.dart';

class CoreModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<AuthStore>(
      (i) => AuthStore(),
      export: true,
    ),
    Bind.lazySingleton<AppLogger>(
      (i) => AppLoggerImpl(),
      export: true,
    ),
    Bind.lazySingleton<LocalStorage>(
      (i) => SharedPreferencesLocalStorageImpl(),
      export: true,
    ),
    Bind.lazySingleton<LocalStorage>(
      (i) => SharedPreferencesLocalStorageImpl(),
      export: true,
    ),
    Bind.lazySingleton<LocalSecureStorage>(
      (_) => FlutterSecureStorageLocalStorageImpl(),
      export: true,
    ),
    Bind.lazySingleton<RestClient>(
      (i) => DioRestClient(
        authStore: i(),
        localStorage: i(),
      ),
      export: true,
    ),
    
  ];
}
