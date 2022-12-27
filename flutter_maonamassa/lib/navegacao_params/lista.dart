import 'package:flutter/material.dart';
import 'package:flutter_maonamassa/navegacao_params/detalhe.dart';

class Lista extends StatelessWidget {
  const Lista({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    settings: const RouteSettings(
                      name: 'detalhe',
                      arguments: {
                        'id':10,
                      }
                    ),
                    builder: (context) => const Detalhe(),
                  ),
                );
              },
              child: const Text(
                'detalhe',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
