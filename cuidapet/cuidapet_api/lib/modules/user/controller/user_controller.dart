import 'dart:async';
import 'dart:convert';

import 'package:cuidapet_api/application/exceptions/user_notfound_exception.dart';
import 'package:cuidapet_api/application/logger/i_logger.dart';
import 'package:cuidapet_api/modules/user/view_models/update_url_avatar_view_model.dart';
import 'package:cuidapet_api/modules/user/view_models/user_update_token_device_input_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'package:cuidapet_api/modules/user/service/i_user_service.dart';

part 'user_controller.g.dart';

@Injectable()
class UserController {
  IUserService userService;
  ILogger log;
  UserController({
    required this.userService,
    required this.log,
  });

  @Route.get('/')
  Future<Response> findByToken(Request request) async {
    try {
      final user = int.parse(request.headers['user']!);
      final userData = await userService.findById(user);
      return Response.ok(jsonEncode({
        'email': userData.email,
        'register_type': userData.registerType,
        'img_avatar': userData.imageAvatar
      }));
    } on UserNotfoundException {
      return Response(204);
    } catch (e, s) {
      log.error('Erro ao buscar usuário', e, s);
      return Response.internalServerError(
          body: jsonEncode({'message': 'Erro ao buscar usuário'}));
    }
  }

  @Route.put('/avatar')
  Future<Response> updateAvatar(Request request) async {
    try {
      final userId = int.parse(request.headers['user']!);
      final updateUrlAvatarViewModel = UpdateUrlAvatarViewModel(
        userId: userId,
        dataRequest: await request.readAsString(),
      );
      final user = await userService.updateAvatar(updateUrlAvatarViewModel);

      return Response.ok(jsonEncode({
        'email': user.email,
        'register_type': user.registerType,
        'img_avatar': user.imageAvatar
      }));
    } catch (e, s) {
      log.error('Erro ao atualizar avatar', e, s);
      return Response.internalServerError(
          body: {'message': 'Erro ao atualizar avatar'});
    }
  }

  @Route.put('/device')
  Future<Response> updateDeviceToken(Request request) async {
    try {
      final userId = int.parse(request.headers['user']!);
      final updateDeviceToken = UserUpdateTokenDeviceInputModel(
        userId: userId,
        dataRequest: await request.readAsString(),
      );
      await userService.updateDeviceToken(updateDeviceToken);
      return Response.ok(jsonEncode({}));
    } catch (e, s) {
      log.error('Erro ao atualizar o device token', e, s);
      return Response.internalServerError();
    }
  }

  Router get router => _$UserControllerRouter(this);
}
