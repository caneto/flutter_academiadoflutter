import 'package:flutter/material.dart';

class StackPage2 extends StatelessWidget {
  const StackPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stack 2'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    'https://blog.maxmilhas.com.br/wp-content/uploads/2019/06/Praia-do-Forno-Arraial-dAjuda-770x450.jpg',
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            color: Colors.white38,
          ),
          Positioned(
            bottom: 48,
            right: 10,
            left: 10,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9)
              ),
              elevation: 12,
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Rio de Janeiro',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                        'Elencar as melhores praias do Rio de Janeiro não é tarefa fácil, mas a gente quer muito que você conheça os melhores lugares e curta o que o destino tem de mais incrível. Por isso, embarcamos nessa aventura e criamos a lista definitiva das melhores praias do Rio de Janeiro. '),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
