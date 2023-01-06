import 'package:flutter/material.dart';
import 'package:flutter_inherited_widget_exemple/home/home_page.dart';
import 'package:flutter_inherited_widget_exemple/splash/splash_page.dart';

import 'model/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UserModel(
      name: 'Carlos Alberto',
      birthDate: '29/04/1966',
      imgAvatar: 'https://avatars.githubusercontent.com/u/2157300?v=4',
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Inherited Widget Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (_) => const SplashPage(),
          '/home': (_) => const HomePage(),
        },
      ),
    );
  }
}

