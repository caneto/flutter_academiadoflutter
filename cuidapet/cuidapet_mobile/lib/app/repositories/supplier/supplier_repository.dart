import '../../entities/address_entity.dart';
import '../../models/supplier_category_model.dart';
import '../../models/supplier_model.dart';
import '../../models/supplier_nearby_me_model.dart';
import '../../models/supplier_services_model.dart';

abstract class SupplierRepository {
  Future<List<SupplierCategoryModel>> getCategories();
  Future<List<SupplierNearbyMeModel>> getSuppliersNearbyMe(
    AddressEntity address,
  );
  Future<SupplierModel> getSupplierById(int id);
  Future<List<SupplierServicesModel>> getServices(int supplierId);
}
