import 'package:flutter/material.dart';

import '../home_controller.dart';
import 'home_address_widget.dart';
import 'home_categories_widget.dart';
import 'home_supplier_tab.dart';

class HomePersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final HomeController controller;

  HomePersistentHeaderDelegate(
    this.controller,
  );

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Column(
      children: [
        HomeAddressWidget(controller: controller),
        HomeCategoriesWidget(controller: controller),
        HomeSupplierTab(controller: controller),
      ],
    );
  }

  @override
  double get maxExtent => 275;

  @override
  double get minExtent => 275;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  TickerProvider? get vsync => null;
}
