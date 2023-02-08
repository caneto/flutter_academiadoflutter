import 'package:cuidapet_api/entities/category.dart';

abstract class ICategoriesService {
  Future<List<Category>> findAll();
}
