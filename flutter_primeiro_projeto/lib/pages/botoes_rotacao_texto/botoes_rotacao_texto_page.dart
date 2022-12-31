import 'package:flutter/material.dart';

class BotoesRotacaoTextoPage extends StatelessWidget {
  const BotoesRotacaoTextoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Botões, Rotações e Texto'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                RotatedBox(
                  quarterTurns: 1,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.red,
                    child: const Text('Carlos'),
                  ),
                ),
                const Icon(Icons.dangerous)
              ],
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                  padding: const EdgeInsets.all(30),
                  minimumSize: const Size(60, 24),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(60)))),
              child: const Text('Salvar'),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.icecream_sharp),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shadowColor: Colors.black,
                minimumSize: const Size(120, 50),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(60))),
              ),
              child: const Text('Ajuda'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.accessibility_rounded),
              label: const Text('Botão'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                shadowColor: Colors.black,
                minimumSize: const Size(120, 50),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(60))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all(Colors.grey),
                  //minimumSize: MaterialStateProperty.all(
                  //  const Size(120, 50),
                  //),
                  minimumSize: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const Size(150, 150);
                    } else if(states.contains(MaterialState.hovered)) {
                      return const Size(180, 180);
                    }
                    return const Size(120, 50);
                  }),
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.black;
                    } else if(states.contains(MaterialState.hovered)) {
                      return Colors.amber;
                    }
                    return Colors.red;
                  })),
              child: const Text('Salvando'),
            ),
            InkWell(
              onTap: () {},
              child: const Text('InkWell'),
            ),
            GestureDetector(
              child: const Text('Gestor detector'),
              onTap: () => print('Gestor Clicado'),
              onVerticalDragStart: (_) => print('Gestor Movimentado'),
            ),
            Container(
              width: 300,
              height: 100,
              decoration: BoxDecoration(
                  gradient:
                      const LinearGradient(colors: [Colors.blue, Colors.green]),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 10,
                        offset: Offset(0, 5),
                        color: Colors.black87)
                  ]),
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: (){},
                child: const Center(
                  child: Text('Botão Salvar'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
