import 'package:flutter/material.dart';

class HomeStateLessPage extends StatelessWidget {
  const HomeStateLessPage({Key? key}) : super(key: key);

  final String texto = "Estou no StatelessWidget";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Texto"),) ,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(texto),
            TextButton(
              onPressed: () {
                //texto = 'Alterei o texto do StatelessWidget';
              },
              child: const Text('Alterar Texto'),
            )
          ]
        ),
      ),
    );
  }
}
