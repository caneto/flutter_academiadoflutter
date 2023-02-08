// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../modules/categories/controller/categories_controller.dart' as _i32;
import '../../modules/categories/data/categories_repository.dart' as _i22;
import '../../modules/categories/data/i_categories_repository.dart' as _i21;
import '../../modules/categories/service/categories_service.dart' as _i24;
import '../../modules/categories/service/i_categories_service.dart' as _i23;
import '../../modules/chat/controller/chat_controller.dart' as _i33;
import '../../modules/chat/data/chat_repository.dart' as _i26;
import '../../modules/chat/data/i_chat_repository.dart' as _i25;
import '../../modules/chat/service/chat_service.dart' as _i28;
import '../../modules/chat/service/i_chat_service.dart' as _i27;
import '../../modules/schedules/controller/schedule_controller.dart' as _i18;
import '../../modules/schedules/data/i_schedule_repository.dart' as _i6;
import '../../modules/schedules/data/schedule_repository.dart' as _i7;
import '../../modules/schedules/service/i_schedule_service.dart' as _i9;
import '../../modules/schedules/service/schedule_service.dart' as _i10;
import '../../modules/supplier/controller/supplier_controller.dart' as _i31;
import '../../modules/supplier/data/i_supplier_repository.dart' as _i11;
import '../../modules/supplier/data/supplier_repository.dart' as _i12;
import '../../modules/supplier/service/i_supplier_service.dart' as _i29;
import '../../modules/supplier/service/supplier_service.dart' as _i30;
import '../../modules/user/controller/auth_controller.dart' as _i20;
import '../../modules/user/controller/user_controller.dart' as _i19;
import '../../modules/user/data/i_user_repository.dart' as _i13;
import '../../modules/user/data/user_repository.dart' as _i14;
import '../../modules/user/service/i_user_service.dart' as _i15;
import '../../modules/user/service/user_service.dart' as _i16;
import '../database/database_connection.dart' as _i4;
import '../database/i_database_connection.dart' as _i3;
import '../facades/push_notification_facade.dart' as _i17;
import '../logger/i_logger.dart' as _i8;
import 'database_connection_configuration.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.IDatabaseConnection>(
      () => _i4.DatabaseConnection(get<_i5.DatabaseConnectionConfiguration>()));
  gh.lazySingleton<_i6.IScheduleRepository>(() => _i7.ScheduleRepository(
      connection: get<_i3.IDatabaseConnection>(), log: get<_i8.ILogger>()));
  gh.lazySingleton<_i9.IScheduleService>(
      () => _i10.ScheduleService(repository: get<_i6.IScheduleRepository>()));
  gh.lazySingleton<_i11.ISupplierRepository>(() => _i12.SupplierRepository(
      connection: get<_i3.IDatabaseConnection>(), log: get<_i8.ILogger>()));
  gh.lazySingleton<_i13.IUserRepository>(() => _i14.UserRepository(
      connection: get<_i3.IDatabaseConnection>(), log: get<_i8.ILogger>()));
  gh.lazySingleton<_i15.IUserService>(() => _i16.UserService(
      userRepository: get<_i13.IUserRepository>(), log: get<_i8.ILogger>()));
  gh.lazySingleton<_i17.PushNotificationFacade>(
      () => _i17.PushNotificationFacade(log: get<_i8.ILogger>()));
  gh.factory<_i18.ScheduleController>(() => _i18.ScheduleController(
      service: get<_i9.IScheduleService>(), log: get<_i8.ILogger>()));
  gh.factory<_i19.UserController>(() => _i19.UserController(
      userService: get<_i15.IUserService>(), log: get<_i8.ILogger>()));
  gh.factory<_i20.AuthController>(() => _i20.AuthController(
      userService: get<_i15.IUserService>(), log: get<_i8.ILogger>()));
  gh.lazySingleton<_i21.ICategoriesRepository>(() => _i22.CategoriesRepository(
      connection: get<_i3.IDatabaseConnection>(), log: get<_i8.ILogger>()));
  gh.lazySingleton<_i23.ICategoriesService>(() =>
      _i24.CategoriesService(repository: get<_i21.ICategoriesRepository>()));
  gh.lazySingleton<_i25.IChatRepository>(() => _i26.ChatRepository(
      connection: get<_i3.IDatabaseConnection>(), log: get<_i8.ILogger>()));
  gh.lazySingleton<_i27.IChatService>(() => _i28.ChatService(
      repository: get<_i25.IChatRepository>(),
      pushNotificationFacade: get<_i17.PushNotificationFacade>()));
  gh.lazySingleton<_i29.ISupplierService>(() => _i30.SupplierService(
      repository: get<_i11.ISupplierRepository>(),
      userService: get<_i15.IUserService>()));
  gh.factory<_i31.SupplierController>(() => _i31.SupplierController(
      service: get<_i29.ISupplierService>(), log: get<_i8.ILogger>()));
  gh.factory<_i32.CategoriesController>(
      () => _i32.CategoriesController(service: get<_i23.ICategoriesService>()));
  gh.factory<_i33.ChatController>(() => _i33.ChatController(
      service: get<_i27.IChatService>(), log: get<_i8.ILogger>()));
  return get;
}
