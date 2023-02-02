import 'package:cuidapet_api/config/jwt_authentication_middleware.dart';
import 'package:cuidapet_api/controllers/fornecedores/dto/salvar_fornecedor_request.dart';
import 'package:cuidapet_api/controllers/fornecedores/fornecedor_controller.dart';
import 'package:cuidapet_api/core/i_routers_config.dart';
import '../cuidapet_api.dart';

class FornecedorRouters implements IRoutersConfig {
  @override
  void configure(Router router) {
   
    // OK
    router.route("/fornecedor")
      .linkFunction((request) async {
        
        if(request.method == 'POST') {
          final req = SalvarFornecedorRequest();
          req.read(await request.body.decode());
          return FornecedorController().salvarFornecedor(req);
        }
        
           return Response.notFound();
      });

    // OK
    router.route("/fornecedores")
      .link(() => JwtAuthenticationMiddleware())
      .link(() => FornecedorController());
    
    // OK
    router.route("/fornecedores/:id")
      .link(() => JwtAuthenticationMiddleware())
      .link(() => FornecedorController());

    // OK
    router.route("/fornecedores/servicos/:fornecedorId")
      .link(() => JwtAuthenticationMiddleware())
      .link(() => FornecedorController());
    
  }
}
