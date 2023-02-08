part of '../register_page.dart';

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _controller = Modular.get<RegisterController>();
  final _formKey = GlobalKey<FormState>();
  final _loginEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _loginEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AppTextformField(
              label: 'Login',
              controller: _loginEC,
              keyboardType: TextInputType.emailAddress,
              validator: Validatorless.multiple([
                Validatorless.required('Login obrigatório'),
                Validatorless.email('Email inválido'),
              ]),
            ),
            const SizedBox(height: 20),
            AppTextformField(
              label: 'Senha',
              obscureText: true,
              controller: _passwordEC,
              validator: Validatorless.multiple([
                Validatorless.required('Senha obrigatório'),
                Validatorless.min(6, 'No mínimo 6 caracteres'),
              ]),
            ),
            const SizedBox(height: 20),
            AppTextformField(
              label: 'Confirmar senha',
              obscureText: true,
              validator: Validatorless.multiple([
                Validatorless.required('Confirmar senha obrigatório'),
                Validatorless.min(6, 'No mínimo 6 carecteres'),
                Validatorless.compare(_passwordEC, 'Senhas não conferem'),
              ]),
            ),
            const SizedBox(height: 20),
            AppDefaultButton(
              onPressed: _registerUser,
              label: 'Cadastrar',
            ),
          ],
        ),
      ),
    );
  }

  void _registerUser() {
    final formValid = _formKey.currentState?.validate() ?? false;

    if (formValid) {
      FocusScope.of(context).unfocus();
      _controller.register(email: _loginEC.text, password: _passwordEC.text);
    }
  }
}
