
import '../../../models/supplier_services_model.dart';

class ScheduleViewModel {
  final int supplierId;
  final List<SupplierServiceModel> services;
  
  ScheduleViewModel({
    this.supplierId = 0,
    this.services = const [],
  });
  
}
