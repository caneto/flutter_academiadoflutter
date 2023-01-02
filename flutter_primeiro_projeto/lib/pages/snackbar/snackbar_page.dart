import 'package:flutter/material.dart';

class SnackbarPage extends StatelessWidget {
  const SnackbarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SnackBars'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  final snackbar = SnackBar(
                    content: Text('Teste de Snackbar'),
                    backgroundColor: Colors.brown,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                },
                child: const Text('Simple SnackBar'),
              ),
              ElevatedButton(
                onPressed: () {
                  final snackbar = SnackBar(
                    content: Text('Teste de Snackbar'),
                    backgroundColor: Colors.amber,
                    action: SnackBarAction(
                      label: 'Desfazer',
                      onPressed: () {
                        print('Clicado');
                      },
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                },
                child: const Text('Action SnackBar'),
              ),
            ]),
      ),
    );
  }
}
