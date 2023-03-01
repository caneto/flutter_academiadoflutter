import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../home_controller.dart';

class HomeAddressWidget extends StatelessWidget {
  final HomeController controller;

  const HomeAddressWidget({
    required this.controller,
    super.key,
  });

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
