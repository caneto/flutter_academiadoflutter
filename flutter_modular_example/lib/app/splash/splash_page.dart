import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                //Navigator.pushNamed(context, '/categoria');
                //Argumentos: Recupera pelo Moduloar.args.data
                Modular.to.pushNamed('/categoria', arguments: 'Categoria Seleciona');
              },
              child: const Text('Categoria Module'),
            ),
            TextButton(
              onPressed: () {
                //Navigator.pushNamed(context, '/categoria');
                //NamedPArameters: Recupera pelo Moduloar.args.data
                Modular.to.pushNamed('/categoria/produto/Produto_Y/xyz');
              },
              child: const Text('Produto dentro da Categoria Module'),
            ),
            TextButton(
              onPressed: () {
                //Navigator.pushNamed(context, '/categoria');
                //NamedPArameters: Recupera pelo Moduloar.args.params
                Modular.to.pushNamed('/produto/Produto_Y/xyz');
              },
              child: const Text('Produto Module'),
            ),
            TextButton(
              onPressed: () {
                //Navigator.pushNamed(context, '/categoria');
                //Argumentos: Recupera pelo Moduloar.args.queryParams
                Modular.to.pushNamed('/produto/xyz?nome=Produto_x');
              },
              child: const Text('Produto Query Param Module'),
            ),
          ],
        ),
      ),
    );
  }
}
