import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/exceptions/failure.dart';
import '../../../core/exceptions/user_not_exists_exception.dart';
import '../../../core/logger/app_logger.dart';
import '../../../core/ui/widgets/loader.dart';
import '../../../core/ui/widgets/messages.dart';
import '../../../models/social_login_type.dart';
import '../../../services/user/user_service.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final UserService _service;
  final AppLogger _logger;

  const LoginControllerBase({
    required UserService service,
    required AppLogger logger,
  })  : _service = service,
        _logger = logger;

  Future<void> login({required String login, required String password}) async {
    try {
      Loader.show();
      await _service.login(email: login, password: password);
      Loader.hide();
      Modular.to.navigate('/auth/');
    } on Failure catch (e) {
      final errorMessage = e.message ?? 'Error while trying to login';

      Loader.hide();

      _logger.error(errorMessage);
      Messages.alert(errorMessage);
    } on UserNotExistsException {
      const errorMessage = 'Usuário não encontrado';
      Loader.hide();
      _logger.error(errorMessage);
      Messages.alert(errorMessage);
    }
  }

  Future<void> socialLogin(SocialLoginType type) async {
    try {
      Loader.show();
      await _service.socialLogin(type);
      Loader.hide();
      Modular.to.navigate('/auth/');
    } on Failure catch (e, s) {
      const errorMessage = 'Erro ao realizar login social';

      Loader.hide();
      _logger.error(errorMessage, e, s);
      Messages.alert(e.message ?? errorMessage);
    }
  }
}
