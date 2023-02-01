// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'contador_controller.dart';

class ContadorPage extends StatelessWidget {
  const ContadorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Builder");
    final controller = ContadorController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contador Mobx"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Observer(
              builder: (_) {
                return Text(
                  "${controller.counter}",
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            Observer(
              builder: (_) {
                return Text(controller.fullname.first);
              },
            ),
            Observer(
              builder: (_) {
                return Text(controller.fullname.last);
              },
            ),
            Observer(
              builder: (_) {
                return Text(controller.saudacao);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
