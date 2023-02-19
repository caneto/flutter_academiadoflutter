import 'package:flutter_modular/flutter_modular.dart';

import '../../core/database/sqlite_connection_factory.dart';
import '../../core/local_storage/flutter_secure_storage/flutter_secure_storage_local_storage_impl.dart';
import '../../core/local_storage/local_storage.dart';
import '../../core/local_storage/shared_preferences/shared_preferences_local_storage_impl.dart';
import '../../core/logger/app_logger.dart';
import '../../core/logger/app_logger_impl.dart';
import '../../core/rest_client/dio/dio_rest_client.dart';
import '../../core/rest_client/rest_client.dart';
import '../../repositories/address/address_repository.dart';
import '../../repositories/address/address_repository_impl.dart';
import '../../services/address/address_service.dart';
import '../../services/address/address_service_impl.dart';
import 'auth/auth_store.dart';

class CoreModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((_) => SqliteConnectionFactory(), export: true),
    Bind.lazySingleton<AppLogger>((_) => AppLoggerImpl(), export: true),
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
     Bind.lazySingleton<AuthStore>(
      (i) => AuthStore(
        localStorage: i<LocalStorage>(),
        localSecureStorage: i<LocalSecureStorage>(),
        addressService: i<AddressService>(),
      ),
      export: true,
    ),
    Bind.lazySingleton<RestClient>(
      (i) => DioRestClient(
        authStore: i(),
        localStorage: i(),
        localSecureStorage: i(),
        log: i(),
      ),
      export: true,
    ),
    Bind.lazySingleton<AddressRepository>(
      (i) => AddressRepositoryImpl(
             connectionFactory: i<SqliteConnectionFactory>(),
          ),
      export: true,
    ),
    Bind.lazySingleton(
      (i) => AddressServiceImpl(
        addressRepository: i<AddressRepository>(),
        localStorage: i<LocalStorage>(),
      ),
      export: true,
    ),
  ];
}
