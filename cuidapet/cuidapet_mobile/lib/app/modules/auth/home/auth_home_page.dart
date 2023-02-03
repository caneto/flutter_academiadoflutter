import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/ui/extensions/screen_size_extension.dart';
import '../../../models/user_model.dart';
import '../../core/auth/auth_store.dart';

class AuthHomePage extends StatefulWidget {
  const AuthHomePage({super.key});

  @override
  State<AuthHomePage> createState() => _AuthHomePageState();
}

class _AuthHomePageState extends State<AuthHomePage> {
  final _controller = Modular.get<AuthStore>();

  @override
  void initState() {
    super.initState();
    reaction<UserModel?>((_) => _controller.loggedUser, (loggedUser) {
      if (loggedUser != null && loggedUser.email.isNotEmpty) {
        Modular.to.navigate('/home/');
      } else {
        Modular.to.navigate('/auth/login/');
      }
    });

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _controller.loadLoggedUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: 162.w,
          height: 130.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
