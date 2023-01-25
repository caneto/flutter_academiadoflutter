import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_example/app/categoria/model/categoria_controller.dart';

// ignore: must_be_immutable
class CategoriaPage extends StatefulWidget {
  final String? categoria;

  CategoriaPage({Key? key, this.categoria})
      : //categoria = Modular.args.data,
        super(key: key);

  @override
  State<CategoriaPage> createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<CategoriaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categoria'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(widget.categoria ?? 'Não vou enviado a categoria'),
            TextButton(
              onPressed: () {
                var controller = Modular.get<CategoriaController>();
              },
              child: const Text('Get Controller'),
            )
          ],
        ),
      ),
    );
  }
}
