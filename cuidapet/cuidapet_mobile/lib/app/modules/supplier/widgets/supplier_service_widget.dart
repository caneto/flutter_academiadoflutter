import 'package:flutter/material.dart';

import '../../../core/ui/extensions/theme_extension.dart';

class SupplierServiceWidget extends StatelessWidget {
  const SupplierServiceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.pets)),
      trailing: Icon(
        Icons.add_circle,
        color: context.primaryColor,
        size: 30,
      ),
      title: const Text('Consulta'),
      subtitle: const Text(r'R$ 100,00'),
    );
  }
}
