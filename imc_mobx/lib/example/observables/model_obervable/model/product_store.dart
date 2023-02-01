import 'package:imc_mobx/example/model/product_model.dart';
import 'package:mobx/mobx.dart';
part 'product_store.g.dart';

class ProductStore = ProductStoreBase with _$ProductStore;

abstract class ProductStoreBase with Store {
  @observable
  ProductModel product;
  @observable
  bool selected;

  ProductStoreBase({
    required this.product,
    required this.selected,
  });
}
