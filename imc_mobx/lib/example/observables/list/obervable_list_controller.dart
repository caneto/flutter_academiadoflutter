import 'package:imc_mobx/example/model/product_model.dart';
import 'package:mobx/mobx.dart';
part 'obervable_list_controller.g.dart';

class ObervableListController = ObervableListControllerBase
    with _$ObervableListController;

abstract class ObervableListControllerBase with Store {
  @observable
  // var products = <ProductModel>[];
  var products = <ProductModel>[].asObservable();

  @action
  void loadProducts() {
    // var productsData = [
    //   ProductModel(name: "Computador"),
    //   ProductModel(name: "Celular"),
    //   ProductModel(name: "Teclado"),
    //   ProductModel(name: "Mouse"),
    // ];
    products.addAll([
      ProductModel(name: "Computador"),
      ProductModel(name: "Celular"),
      ProductModel(name: "Teclado"),
      ProductModel(name: "Mouse"),
    ]);
  }

  @action
  void addProduct() {
    products.add(ProductModel(name: "Computador2"));
  }

  @action
  void removeProduct() {
    products.removeAt(0);
  }
}
