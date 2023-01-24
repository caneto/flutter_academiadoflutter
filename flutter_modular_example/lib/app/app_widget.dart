import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {

  const AppWidget({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       // ignore: prefer_const_constructors
       return MaterialApp.router(
          title: 'Flutter Mudular Example',
          routeInformationParser: Modular.routeInformationParser,
          routerDelegate: Modular.routerDelegate,
       );
       
  }
}