part of '../home_page.dart';

class _HomeAddressWidget extends StatelessWidget {
  final HomeController controller;

  const _HomeAddressWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text('Estabelecimentos próximos de'),
          Observer(
            builder: (_) => Text(
              controller.addressEntity?.address ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
