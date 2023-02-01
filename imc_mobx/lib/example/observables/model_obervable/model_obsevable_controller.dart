import 'package:imc_mobx/example/model/product_model.dart';
import 'package:mobx/mobx.dart';

import 'model/product_store.dart';

part 'model_obsevable_controller.g.dart';

class ModelObsevableController = ModelObsevableControllerBase
    with _$ModelObsevableController;

abstract class ModelObsevableControllerBase with Store {
  @observable
  // var products = <ProductModel>[];
  var products = <ProductStore>[].asObservable();

  @action
  void loadProducts() {
    // var productsData = [
    //   ProductModel(name: "Computador"),
    //   ProductModel(name: "Celular"),
    //   ProductModel(name: "Teclado"),
    //   ProductModel(name: "Mouse"),
    // ];
    products.addAll([
      ProductStore(product: ProductModel(name: "Computador"), selected: false),
      ProductStore(product: ProductModel(name: "Celular"), selected: false),
      ProductStore(product: ProductModel(name: "Teclado"), selected: false),
      ProductStore(product: ProductModel(name: "Mouse"), selected: false),
    ]);
  }

  @action
  void addProduct() {
    products.add(ProductStore(
        product: ProductModel(name: "Computador"), selected: false));
  }

  @action
  void removeProduct() {
    products.removeAt(0);
  }

  @action
  void selectedProduct(int index) {
    var productsSelected = products[index].selected;
    products[index].selected = !productsSelected;
  }
}
