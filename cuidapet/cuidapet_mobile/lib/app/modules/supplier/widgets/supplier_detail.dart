import 'package:flutter/material.dart';

import '../../../core/ui/extensions/theme_extension.dart';
import '../../../models/supplier_model.dart';

class SupplierDetail extends StatelessWidget {
  final SupplierModel supplier;

  const SupplierDetail({required this.supplier, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          child: Center(
            child: Text(
              supplier.name,
              style: context.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: context.primaryColor,
        ),
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'Informações do estabelecimento',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.location_city,
            color: Colors.black,
          ),
          title: Text(supplier.address),
        ),
        ListTile(
          leading: const Icon(
            Icons.local_phone,
            color: Colors.black,
          ),
          title: Text(supplier.phone),
        ),
        Divider(
          thickness: 1,
          color: context.primaryColor,
        ),
      ],
    );
  }
}
