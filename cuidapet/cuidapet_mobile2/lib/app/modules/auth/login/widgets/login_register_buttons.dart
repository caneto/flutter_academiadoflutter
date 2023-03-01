part of '../login_page.dart';

class _LoginRegisterButtons extends StatelessWidget {
  final _controller = Modular.get<LoginController>();
  final _roundedButtonWidth = 0.42.sw;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: [
        RoundedButtonWithIcon(
          onTap: () => _controller.socialLogin(SocialLoginType.facebook),
          width: _roundedButtonWidth,
          color: ColorsApp.instance.facebookColor,
          icon: AppIcons.facebook,
          label: 'Facebook',
        ),
        RoundedButtonWithIcon(
          onTap: () => _controller.socialLogin(SocialLoginType.google),
          width: _roundedButtonWidth,
          color: ColorsApp.instance.googleColor,
          icon: AppIcons.google,
          label: 'Google',
        ),
        RoundedButtonWithIcon(
          onTap: () => Navigator.pushNamed(context, '/auth/register/'),
          width: _roundedButtonWidth,
          color: context.primaryColorDark,
          icon: Icons.mail,
          label: 'Cadastre-se',
        ),
      ],
    );
  }
}
