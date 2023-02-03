// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidapet/app/models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:cuidapet/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet/app/modules/core/auth/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class AuthHomePage extends StatefulWidget {
  final AuthStore _authStore;

  const AuthHomePage({
    Key? key,
    required AuthStore authStore,
  })  : _authStore = authStore,
        super(key: key);

  @override
  State<AuthHomePage> createState() => _AuthHomePageState();
}

class _AuthHomePageState extends State<AuthHomePage> {

  @override
  void initState() {
    super.initState();

    reaction<UserModel?>((_) => widget._authStore.userLogged, (userLogged) {
      if(userLogged != null && userLogged.email.isNotEmpty) {
        Modular.to.navigate('/home');
      } else {
        Modular.to.navigate('/auth/login/');
      }
    });

    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      widget._authStore.loadUSerLogged();
     });
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
