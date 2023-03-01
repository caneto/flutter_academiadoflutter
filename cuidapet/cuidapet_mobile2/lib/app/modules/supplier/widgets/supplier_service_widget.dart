import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/helpers/text_formatter.dart';
import '../../../core/ui/extensions/theme_extension.dart';
import '../../../models/supplier_services_model.dart';
import '../supplier_controller.dart';

class SupplierServiceWidget extends StatelessWidget {
  final SupplierServicesModel service;
  final SupplierController supplierController;

  const SupplierServiceWidget({
    required this.service,
    required this.supplierController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.pets)),
      trailing: Observer(
        builder: (_) {
          return IconButton(
            onPressed: () {
              supplierController.addOrRemoveService(service);
            },
            icon: supplierController.isServiceSelected(service)
                ? const Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                    size: 30,
                  )
                : Icon(
                    Icons.add_circle,
                    color: context.primaryColor,
                    size: 30,
                  ),
          );
        },
      ),
      title: Text(service.name),
      subtitle: Text(TextFormatter.formatReal(service.price)),
    );
  }
}
