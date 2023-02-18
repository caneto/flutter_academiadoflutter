// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/exceptions/failure.dart';
import '../../../core/exceptions/user_exists_exception.dart';
import '../../../core/logger/app_logger.dart';
import '../../../core/ui/widgets/loader.dart';
import '../../../core/ui/widgets/messages.dart';
import '../../../services/user/user_service.dart';

part 'register_controller.g.dart';

class RegisterController = _RegisterControllerBase with _$RegisterController;

abstract class _RegisterControllerBase with Store {
  final UserService _userService;
  final AppLogger _log;
  _RegisterControllerBase({
    required UserService userService,
    required AppLogger log,
  })  : _userService = userService,
        _log = log;

  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      Loader.show();
      await _userService.register(email: email, password: password);
      Loader.hide();

      Messages.success(
        'Usuário cadastrado com sucesso! Por favor, confirme seu e-mail.',
      );

      Modular.to.pop();
    } on UserExistsException {
      Loader.hide();
      Messages.alert('Email já utilizado.');
    } on Failure catch (e, s) {
      _log.error('Erro ao registrar ', e, s);
      Loader.hide();
      Messages.alert(e.message ?? 'Erro ao registrar usuário');
    }
  }
}
