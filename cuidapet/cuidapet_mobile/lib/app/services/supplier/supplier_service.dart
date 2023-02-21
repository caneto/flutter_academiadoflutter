import '../../models/supplier_category_model.dart';

abstract class SupplierService {
  Future<List<SupplierCategoryModel>> getCategories();
}
