// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$UserControllerRouter(UserController service) {
  final router = Router();
  router.add('GET', r'/', service.findByToken);
  router.add('PUT', r'/avatar', service.updateAvatar);
  router.add('PUT', r'/device', service.updateDeviceToken);
  return router;
}
