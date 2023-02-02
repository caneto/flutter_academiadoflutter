import 'package:cuidapet_api/config/jwt_authentication_middleware.dart';
import 'package:cuidapet_api/controllers/usuario/usuario_controller.dart';
import 'package:cuidapet_api/controllers/usuario/usuario_update_controller.dart';
import 'package:cuidapet_api/core/i_routers_config.dart';
import '../cuidapet_api.dart';

class UsuarioRouters implements IRoutersConfig {
  
  @override
  void configure(Router router) {
    router
      .route("/usuario")
      .link(() => JwtAuthenticationMiddleware())
      .link(() => UsuarioController());
      
    router
      .route("/usuario/avatar")
      .link(() => JwtAuthenticationMiddleware())
      .link(() => UsuarioController());

    router
      .route("/usuario/device")
      .link(() => JwtAuthenticationMiddleware())
      .link(() => UsuarioUpdateController());
  }
}
