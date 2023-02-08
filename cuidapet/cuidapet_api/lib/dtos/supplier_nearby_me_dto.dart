
class SupplierNearbyMeDTO {
  
  int id;
  String name;
  String? logo;
  double distance;
  int categoryId;

  SupplierNearbyMeDTO({
    required this.id,
    required this.name,
    this.logo,
    required this.distance,
    required this.categoryId,
  });
  
}
