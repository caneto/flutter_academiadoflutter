part of '../home_page.dart';

class _HomeCategoriesWidget extends StatelessWidget {
  final HomeController controller;

  const _HomeCategoriesWidget({required this.controller});

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

  //final SupplierCategoryModel category;

  const _CategoryItem({
    //required this.category,
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
      //onTap: () => controller.changeSupplierCategoryFilter(category),
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Observer(
              builder: (_) => CircleAvatar(
                //backgroundColor:
                //    controller.supplierCategoryFilterSelected?.id == category.id
                //        ? context.primaryColor
                //        : context.primaryColorLight,
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
