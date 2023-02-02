import 'package:cuidapet_api/config/jwt_authentication_middleware.dart';
import 'package:cuidapet_api/controllers/categorias/categorias_controller.dart';
import 'package:cuidapet_api/core/i_routers_config.dart';
import '../cuidapet_api.dart';

class CategoriasRouters implements IRoutersConfig {
  @override
  void configure(Router router) {
    
    router.route('/categorias/')
      .link(() => JwtAuthenticationMiddleware())
      .link(() => CategoriasController());
  }
}
