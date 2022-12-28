import 'package:flutter/material.dart';
import 'package:flutter_maonamassa_navegacao/pages/detalhe_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('/detalhe', arguments: 'Parametro X');
              },
              child: const Text('Ir para Detalhe'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  settings: const RouteSettings(name: '/detalhe', arguments: 'Parametro pelo page route'),
                  builder: (_) => const DetalhePage(),
                ));
              },
              child: const Text('Ir para Detalhe PageRoute'),
            ),
            TextButton(
              onPressed: () async {
                String message =  await Navigator.of(context)
                    .pushNamed('/detalhe2') as String;
                print('Mensagem recebida da pagina: $message');
              },
              child: const Text('Ir para Detalhe2 e aguardar'),
            ),
          ],
        ),
      ),
    );
  }
}
