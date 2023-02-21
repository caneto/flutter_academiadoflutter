import './supplier_service.dart';
import '../../models/supplier_category_model.dart';
import '../../repositories/supplier/supplier_repository.dart';

class SupplierServiceImpl implements SupplierService {
  final SupplierRepository _repository;

  SupplierServiceImpl({required SupplierRepository repository})
      : _repository = repository;

  @override
  Future<List<SupplierCategoryModel>> getCategories() =>
      _repository.getCategories();
}
