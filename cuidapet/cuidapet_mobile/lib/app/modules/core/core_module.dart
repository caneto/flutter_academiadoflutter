import 'package:flutter_modular/flutter_modular.dart';

import 'auth/auth_store.dart';

class CoreModule extends Module {
  @override
  final List<Bind> binds = [
    
    Bind.lazySingleton<AuthStore>(
      (i) => AuthStore(),
      export: true,
    ),
  ];
}
