import 'package:flutter/material.dart';

import 'example/contador/contador_page.dart';
import 'example/contador_codegen/contador_codegen_page.dart';
import 'example/observables/list/observable_list_page.dart';
import 'example/observables/model_obervable/model_obeservable_page.dart';
import 'imc/imc_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Imc Mobx Examples',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/imcPage",
      routes: {
        "/imcPage": (context) => const ImcPage(),
        "/observableList": (context) => const ObservableListPage(),
        "/modelObservable": (context) => const ModelObservablePage(),
        "/contador": (context) => const ContadorPage(),
        "/contadorCodegen": (context) => const ContadorCodegenPage(),
      },
    );
  }
}
