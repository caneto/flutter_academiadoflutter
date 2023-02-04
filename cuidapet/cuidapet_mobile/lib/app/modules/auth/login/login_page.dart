import 'package:flutter/material.dart';

import '../../../core/ui/widgets/cuidapet_textform_field.dart';

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
              CuidapetTextformField(
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
            ],
          ),
        ),
      ),
    );
  }
}
