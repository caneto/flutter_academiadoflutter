import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_example/app/produto/produto_page.dart';

import 'produto_page2.dart';

class ProdutoModulo extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/:nome/xyz',
        child: (context, args) => ProdutoPage(
              nome: args.params['nome'],
            )),
    ChildRoute('/xyz',
        child: (context, args) => ProdutoPage2(
              nome: args.queryParams['nome'],
            ))
  ];
}
