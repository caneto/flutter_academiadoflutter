part of '../address_detail_page.dart';

class _SaveAddressButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveAddressButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.9.sw,
      height: 60.h,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: AppDefaultButton(
        onPressed: onPressed,
        label: 'Salvar',
      ),
    );
  }
}
