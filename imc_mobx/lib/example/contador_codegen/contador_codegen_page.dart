// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import 'contador_codegen_controller.dart';

class ContadorCodegenPage extends StatefulWidget {
  const ContadorCodegenPage({Key? key}) : super(key: key);

  @override
  State<ContadorCodegenPage> createState() => _ContadorCodegenPageState();
}

class _ContadorCodegenPageState extends State<ContadorCodegenPage> {
  final controller = ContadorCodegenController();

  final reactionDisposer = <ReactionDisposer>[];

  @override
  void initState() {
    super.initState();

    var autorunDisposer = autorun(
      (_) {
        print("---------------- auto run ---------------");
        print(controller.fullName.first);
      },
    );

    //** reaction no´s falamos para o mobx qual o atributo observavel que queremos observar!!!*/
    final reactionDispose = reaction(
      (_) => controller.counter,
      (counter) {
        print("---------------reaction--------------");
        print(counter);
      },
    );

    final whenDisposer = when(
      (p0) => controller.fullName.first == "Rodrigo",
      () {
        print("------------ when ---------------------");
        print(controller.fullName.first);
      },
    );

    reactionDisposer.add(autorunDisposer);
    reactionDisposer.add(reactionDispose);
    reactionDisposer.add(whenDisposer);
  }

  @override
  void dispose() {
    super.dispose();
    for (var reaction in reactionDisposer) {
      reaction();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Builder");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contador Mobx Codegen"),
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
                return Text(controller.fullName.first);
              },
            ),
            Observer(
              builder: (_) {
                return Text(controller.fullName.last);
              },
            ),
            Observer(
              builder: (_) {
                return Text(controller.saudacao);
              },
            ),
            TextButton(
                onPressed: () {
                  controller.changeName();
                },
                child: const Text("Change name")),
            TextButton(
                onPressed: () {
                  controller.rollBackName();
                },
                child: const Text("RollBack name")),
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
