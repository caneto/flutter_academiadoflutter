import 'package:cuidapet_api/config/jwt_authentication_middleware.dart';
import 'package:cuidapet_api/controllers/chat/chat_controller.dart';
import 'package:cuidapet_api/core/i_routers_config.dart';

import '../cuidapet_api.dart';

class ChatRouter implements IRoutersConfig {
  @override
  void configure(Router router) {
    
    router.route('/chats/usuario')
      .link(() => JwtAuthenticationMiddleware())
      .link(() => ChatController());

    router.route('/chats/notificar')
      .link(() => JwtAuthenticationMiddleware())
      .link(() => ChatController());

    router.route('/chats/close/:id')
      .link(() => JwtAuthenticationMiddleware())
      .link(() => ChatController());
  }
}
