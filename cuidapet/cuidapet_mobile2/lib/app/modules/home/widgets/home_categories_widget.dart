import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/ui/extensions/theme_extension.dart';
import '../../../models/supplier_category_model.dart';
import '../home_controller.dart';

class HomeCategoriesWidget extends StatelessWidget {
  final HomeController controller;

  const HomeCategoriesWidget({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Observer(
        builder: (_) => Center(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.categories.length,
            itemBuilder: (_, index) => _CategoryItem(
              category: controller.categories[index],
              controller: controller,
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final HomeController controller;

  final SupplierCategoryModel category;

  const _CategoryItem({
    required this.category,
    required this.controller,
  });

  static const _categoryIcons = {
    'P': Icons.pets,
    'V': Icons.local_hospital,
    'C': Icons.store_mall_directory,
  };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.changeSupplierCategoryFilter(category),
      child: Container(
        width: 90,
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(blurRadius: 7.2, color: Colors.black38, spreadRadius: 0.2)
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Observer(
              builder: (_) => CircleAvatar(
                backgroundColor:
                    controller.supplierCategoryFilterSelected?.id == category.id
                        ? context.primaryColor
                        : context.primaryColorLight,
                radius: 30,
                child: Icon(
                  _categoryIcons[category.type],
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(category.name),
          ],
        ),
      ),
    );
  }
}
