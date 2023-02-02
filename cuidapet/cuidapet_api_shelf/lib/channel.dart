import 'package:cuidapet_api/config/database_params_config.dart';
import 'package:cuidapet_api/routers/agendamento_router.dart';
import 'package:cuidapet_api/routers/categorias_router.dart';
import 'package:cuidapet_api/routers/chat_router.dart';
import 'package:cuidapet_api/routers/fornecedor_router.dart';
import 'package:cuidapet_api/routers/login_router.dart';
import 'package:cuidapet_api/routers/usuario_router.dart';

import 'cuidapet_api.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class CuidapetApiChannel extends ApplicationChannel {
  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    
    // Carregando os dados do banco de dados
    DatabaseParamsConfig.load(options.configurationFilePath);
    
    // Habilitando Cors
    CORSPolicy.defaultPolicy.allowedOrigins = ['*'];
    CORSPolicy.defaultPolicy.allowedMethods = ["PATCH", "GET", "POST", "PUT", "DELETE"];
    CORSPolicy.defaultPolicy.allowedRequestHeaders = ["*"];
    CORSPolicy.defaultPolicy.allowCredentials = true;
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();
    LoginRouters().configure(router);
    CategoriasRouters().configure(router);
    FornecedorRouters().configure(router);
    AgendamentoRouter().configure(router);
    UsuarioRouters().configure(router);
    ChatRouter().configure(router);
    
    return router;
  }
}