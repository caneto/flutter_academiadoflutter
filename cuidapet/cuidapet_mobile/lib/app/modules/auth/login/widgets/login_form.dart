part of '../login_page.dart';

class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _controller = Modular.get<LoginController>();
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
      child: Column(
        children: [
          AppTextformField(
            label: 'Login',
            keyboardType: TextInputType.emailAddress,
            controller: _loginEC,
             validator: Validatorless.multiple([
              Validatorless.required('Login obrigatório'),
              Validatorless.email('E-mail inválido'),
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          AppTextformField(
            label: 'Senha',
            obscureText: true,
            controller: _passwordEC,
            validator: Validatorless.multiple([
              Validatorless.required('Senha obrigatório'),
              Validatorless.min(6, 'Deve conter 6 carecteres'),
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          AppDefaultButton(
            onPressed: _login,
            label: 'Entrar',
          ),
        ],
      ),
    );
  }

  void _login() {
    final formValid = _formKey.currentState?.validate() ?? false;

    if (formValid) {
      FocusScope.of(context).unfocus();
      _controller.login(login: _loginEC.text, password: _passwordEC.text);
    }
  }
}
