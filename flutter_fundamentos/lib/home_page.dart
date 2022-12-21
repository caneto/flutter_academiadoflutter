import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  String texto = "Estou no StatelessWidget";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Texto"),) ,
      body: Column(children: [
        Text(texto),
        TextButton(
          onPressed: () {
            texto = 'Alterei o texto do StatelessWidget';
          },
          child: const Text('Alterar Texto'),
        )
      ]),
    );
  }
}
