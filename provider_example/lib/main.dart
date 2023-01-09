import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_exemple/provider/user_model.dart';

import 'provider/provider_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        return UserModel(
          name: 'Carlos Aberto',
          imgAvatar: 'https://avatars.githubusercontent.com/u/2157300?v=4',
          birthDate: '29/04/1966',
        );
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {'/provider': (_) => const ProviderPage()},
        home: Builder(
          builder: (BuildContext context) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/provider');
                      },
                      child: const Text('Provider'),
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: const Text('Change Notifier')),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
