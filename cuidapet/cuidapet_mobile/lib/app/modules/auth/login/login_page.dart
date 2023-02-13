// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/helpers/enviroments.dart';
import '../../../core/ui/extensions/screen_size_extension.dart';
import '../../../core/ui/extensions/theme_extension.dart';
import '../../../core/ui/icons/app_icons.dart';
import '../../../core/ui/styles/colors_app.dart';
import '../../../core/ui/widgets/app_default_button.dart';
import '../../../core/ui/widgets/app_textform_field.dart';
import '../../../core/ui/widgets/rounded_button_with_icon.dart';
import '../../../models/social_login_type.dart';
import 'login_controller.dart';
part 'widgets/login_form.dart';
part 'widgets/login_divider.dart';
part 'widgets/login_register_buttons.dart';

class LoginPage extends StatelessWidget {
  final loginEC = TextEditingController();
  final senhaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text(Environments.params('base_url') ?? ''),
              SizedBox(
                height: 50.h,
              ),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 162.w,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                 height: 20,
              ),
              const _LoginForm(),
              const SizedBox(
                 height: 8,
              ),
              const _OrSeparator(),
              _LoginRegisterButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrSeparator extends StatelessWidget {
  const _OrSeparator();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _LoginDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'OU',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: context.primaryColor,
            ),
          ),
        ),
        const _LoginDivider(),
      ],
    );
  }
}
