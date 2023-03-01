part of '../login_page.dart';

class _LoginDivider extends StatelessWidget {
  const _LoginDivider();

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Divider(thickness: 1, color: context.primaryColor));
  }
}
