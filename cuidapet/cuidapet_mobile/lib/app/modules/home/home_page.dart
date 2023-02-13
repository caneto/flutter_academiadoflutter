import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/auth/auth_store.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              ListTile(
                title: const Text('Sair'),
                onTap: () async {
                  await Modular.get<AuthStore>().logout();

                  Modular.to.navigate('/auth/');
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(),
    );
  }
}
