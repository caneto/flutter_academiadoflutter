import '../../entities/address_entity.dart';
import '../../models/supplier_category_model.dart';
import '../../models/supplier_model.dart';
import '../../models/supplier_nearby_me_model.dart';
import '../../models/supplier_service_model.dart';

abstract class SupplierService {
  Future<List<SupplierCategoryModel>> getCategories();
  Future<List<SupplierNearbyMeModel>> getSuppliersNearbyMe(
    AddressEntity address,
  );
  Future<SupplierModel> getSupplierById(int id);
  Future<List<SupplierServiceModel>> getServices(int supplierId);
}
