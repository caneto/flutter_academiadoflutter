// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_obsevable_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ModelObsevableController on ModelObsevableControllerBase, Store {
  late final _$productsAtom =
      Atom(name: 'ModelObsevableControllerBase.products', context: context);

  @override
  ObservableList<ProductStore> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableList<ProductStore> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$ModelObsevableControllerBaseActionController =
      ActionController(name: 'ModelObsevableControllerBase', context: context);

  @override
  void loadProducts() {
    final _$actionInfo = _$ModelObsevableControllerBaseActionController
        .startAction(name: 'ModelObsevableControllerBase.loadProducts');
    try {
      return super.loadProducts();
    } finally {
      _$ModelObsevableControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addProduct() {
    final _$actionInfo = _$ModelObsevableControllerBaseActionController
        .startAction(name: 'ModelObsevableControllerBase.addProduct');
    try {
      return super.addProduct();
    } finally {
      _$ModelObsevableControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeProduct() {
    final _$actionInfo = _$ModelObsevableControllerBaseActionController
        .startAction(name: 'ModelObsevableControllerBase.removeProduct');
    try {
      return super.removeProduct();
    } finally {
      _$ModelObsevableControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectedProduct(int index) {
    final _$actionInfo = _$ModelObsevableControllerBaseActionController
        .startAction(name: 'ModelObsevableControllerBase.selectedProduct');
    try {
      return super.selectedProduct(index);
    } finally {
      _$ModelObsevableControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
products: ${products}
    ''';
  }
}
