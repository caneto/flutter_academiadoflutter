import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

// ignore: must_be_immutable
class ProdutoPage2 extends StatelessWidget {

  final String? nome;
  
  const ProdutoPage2({Key? key, this.nome}) : super(key: key);

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
        ],
      ),
    );
  }
}
