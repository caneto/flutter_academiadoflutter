import './supplier_service.dart';
import '../../entities/address_entity.dart';
import '../../models/supplier_category_model.dart';
import '../../models/supplier_model.dart';
import '../../models/supplier_nearby_me_model.dart';
import '../../models/supplier_services_model.dart';
import '../../repositories/supplier/supplier_repository.dart';

class SupplierServiceImpl implements SupplierService {
  final SupplierRepository _repository;

  SupplierServiceImpl({required SupplierRepository repository})
      : _repository = repository;

  @override
  Future<List<SupplierCategoryModel>> getCategories() =>
      _repository.getCategories();

  @override
  Future<List<SupplierNearbyMeModel>> getSuppliersNearbyMe(
    AddressEntity address,
  ) =>
      _repository.getSuppliersNearbyMe(address);

  @override
  Future<SupplierModel> getSupplierById(int id) =>
      _repository.getSupplierById(id);

  @override
  Future<List<SupplierServicesModel>> getServices(int supplierId) =>
      _repository.getServices(supplierId);
}
