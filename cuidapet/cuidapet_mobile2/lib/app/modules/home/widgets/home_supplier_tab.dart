import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../home_controller.dart';

class HomeSupplierTab extends StatelessWidget {
  final HomeController controller;

  const HomeSupplierTab({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HomeTabHeader(controller: controller),
      ],
    );
  }
}

class _HomeTabHeader extends StatelessWidget {
  final HomeController controller;

  const _HomeTabHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Text('Estabelecimentos'),
          const Spacer(),
          Observer(
            builder: (_) => InkWell(
              onTap: () =>
                  controller.changeSupplierPageType(SupplierPageType.list),
              child: Icon(
                Icons.view_headline,
                color: controller.suppliersPageType == SupplierPageType.list
                    ? Colors.black
                    : Colors.grey,
              ),
            ),
          ),
          Observer(
            builder: (_) => InkWell(
              onTap: () =>
                  controller.changeSupplierPageType(SupplierPageType.grid),
              child: Icon(
                Icons.view_compact_sharp,
                color: controller.suppliersPageType == SupplierPageType.grid
                    ? Colors.black
                    : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


