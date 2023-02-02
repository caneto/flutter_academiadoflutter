import 'package:cuidapet_api/config/jwt_authentication_middleware.dart';
import 'package:cuidapet_api/controllers/login/login_cadastro_controller.dart';
import 'package:cuidapet_api/controllers/login/login_controller.dart';
import 'package:cuidapet_api/controllers/login/login_refresh_controller.dart';
import 'package:cuidapet_api/core/i_routers_config.dart';
import '../cuidapet_api.dart';

class LoginRouters implements IRoutersConfig {
  @override
  void configure(Router router) {
    
    router.route("/login")
      .link(() => LoginController());
    // Não utiizado
    router.route("/login/password")
      .link(() => JwtAuthenticationMiddleware())
      .link(() => LoginController());

    router.route("/login/cadastrar")
      .link(() => LoginCadastroController());

    router.route("/login/refresh/")
      .link(() => LoginRefreshController());

    router.route("/login/confirmar")
      .link(() => JwtAuthenticationMiddleware())
      .link(() => LoginController());


    router.route("/login/isSupplier")
      .link(() => JwtAuthenticationMiddleware())
      .link(() => LoginController());
    

  }
}
