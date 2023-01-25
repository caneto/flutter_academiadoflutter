import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_example/app/categoria/model/preco_model.dart';

// ignore: must_be_immutable
class ProdutoPage extends StatelessWidget {
  final String? nome;

  const ProdutoPage({Key? key, this.nome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produto'),
      ),
      body: Column(
        children: [
          //Modular.args.params['nome']
          Text(nome ?? 'Nome não enviado'),
          TextButton(
              onPressed: () {
                Modular.get<PrecoModel>();
              },
              child: const Text('Get Preço'))
        ],
      ),
    );
  }
}
