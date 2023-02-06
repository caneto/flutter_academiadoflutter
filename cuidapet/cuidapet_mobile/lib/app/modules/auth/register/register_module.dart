import 'package:flutter_modular/flutter_modular.dart';

import 'register_page.dart';

class RegisterModule extends Module {

   @override
   final List<Bind> binds = [];

   @override
   final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => const RegisterPage()),
   ];

}
