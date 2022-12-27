import 'package:flutter/material.dart';
import 'package:flutter_maonamassa_navegacao/core/navigator_observer_custom.dart';
import 'package:flutter_maonamassa_navegacao/pages/detalhe_page.dart';
import 'package:flutter_maonamassa_navegacao/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [
        NavigatorObserverCustom(),
      ],
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => const HomePage(),
          );
        }
        if (settings.name == '/detalhe') {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => const DetalhePage(),
          );
        }
      },

      //routes: {
      //  '/': (_) => const HomePage(),
      //  '/detalhe': (_) => const DetalhePage(),
      //},
    );
  }
}
