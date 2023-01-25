import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_example/app/categoria/categoria_modele.dart';
import 'package:flutter_modular_example/app/produto/produto_modulo.dart';
import 'package:flutter_modular_example/app/splash/splash_page.dart';

class AppModule extends Module {

  // Dependencias
  // Tudos modoso colocados no AppModule nunca é destruido
  @override
  List<Bind<Object>> get binds => const [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(Modular.initialRoute, child: (context, args) => const SplashPage()),
    ModuleRoute('/categoria', module: CategoriaModele()),
    ModuleRoute('/produto', module: ProdutoModulo()),
  ];
  
}

// - Hierarquia
  // Produto
    // Estoque
      // Fornecedor
// App
  // m1 
    // page 1
    // m2
      // page m2