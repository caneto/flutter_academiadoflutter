import 'package:flutter/material.dart';
import 'package:flutter_maonamassa/navegacao/home_page.dart' as navegacao;

import 'navegacao/page1.dart';
import 'navegacao/page2.dart';
import 'navegacao/page3.dart';
import 'navegacao/page4.dart';
import 'navegacao_params/lista.dart';
//import 'package:flutter_maonamassa/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: navegacao.HomePage(),
      initialRoute: '/navegacao_param',
      routes: {
        '/': (_) => const navegacao.HomePage(),
        '/page1': (_) => const Page1(),
        Page2.routeName: (_) => const Page2(),
        '/page3': (_) => const Page3(),
        '/page4': (_) => const Page4(),
        '/navegacao_param': (_) => const Lista(),
      },
    );
  }
}


