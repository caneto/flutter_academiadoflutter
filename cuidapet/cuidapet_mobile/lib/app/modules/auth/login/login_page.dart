import 'package:flutter/material.dart';

import '../../../core/ui/extensions/screen_size_extension.dart';
import '../../../core/ui/icons/app_icons.dart';
import '../../../core/ui/widgets/app_textform_field.dart';
import '../../../core/ui/widgets/rounded_button_with_icon.dart';

class LoginPage extends StatelessWidget {
  final loginEC = TextEditingController();
  final senhaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              AppTextformField(
                label: 'Login',
                controller: loginEC,
                validator: (String? value) {
                  if(value == null || value.isEmpty) {
                    return 'Valor obrigatorio';
                  }
                  return null;
                },
              ),
              Text(loginEC.text),
              ElevatedButton(
                onPressed: () {
                  formKey.currentState?.validate();
                  print(loginEC.text);
                },
                child: Text('Validar'),
              ),
              RoundedButtonWithIcon(onTap: (){}, width: 160.h, color: Colors.blue, icon: AppIcons.facebook, label: 'Facebook'),
              RoundedButtonWithIcon(onTap: (){}, width: 160.h, color: Colors.orange, icon: AppIcons.google, label: 'Google'),
            ],
          ),
        ),
      ),
    );
  }
}
