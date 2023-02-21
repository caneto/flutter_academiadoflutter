import '../../models/supplier_category_model.dart';

abstract class SupplierRepository {
  Future<List<SupplierCategoryModel>> getCategories();
}
