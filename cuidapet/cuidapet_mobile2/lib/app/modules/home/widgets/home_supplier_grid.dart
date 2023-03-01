import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/ui/extensions/theme_extension.dart';
import '../../../models/supplier_nearby_me_model.dart';
import '../home_controller.dart';

class HomeSupplierGrid extends StatelessWidget {
  final HomeController controller;

  const HomeSupplierGrid({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        Observer(
          builder: (_) => SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (_, index) => _HomeSupplierCardItemWidget(
                supplier: controller.suppliersByAddress[index],
              ),
              childCount: controller.suppliersByAddress.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.1,
            ),
          ),
        ),
      ],
    );
  }
}

class _HomeSupplierCardItemWidget extends StatelessWidget {
  final SupplierNearbyMeModel supplier;

  const _HomeSupplierCardItemWidget({required this.supplier});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed('/supplier/', arguments: supplier.id),
      child: Stack(
        children: [
          Card(
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            margin:
                const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
            child: SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      supplier.name,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleSmall,
                    ),
                    Text(
                      '${supplier.distance.toStringAsFixed(2)} km',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[200],
            ),
          ),
          Positioned(
            top: 4,
            left: 0,
            right: 0,
            child: Center(
              child: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(supplier.logo),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
