// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$AuthControllerRouter(AuthController service) {
  final router = Router();
  router.add('POST', r'/', service.login);
  router.add('POST', r'/register', service.saveUser);
  router.add('PATCH', r'/confirm', service.confirmLogin);
  router.add('PUT', r'/refresh', service.refreshToken);
  return router;
}
