import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'model_obsevable_controller.dart';

class ModelObservablePage extends StatefulWidget {
  const ModelObservablePage({Key? key}) : super(key: key);

  @override
  State<ModelObservablePage> createState() => _ModelObservablePageState();
}

class _ModelObservablePageState extends State<ModelObservablePage> {
  final controller = ModelObsevableController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Model Observable'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Observer(
              builder: (_) {
                return ListView.builder(
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    final productStore = controller.products[index];
                    return Observer(
                      builder: (_) {
                        return CheckboxListTile(
                          value: productStore.selected,
                          onChanged: (_) {
                            controller.selectedProduct(index);
                          },
                          title: Text(productStore.product.name),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    controller.addProduct();
                  },
                  child: const Text("Adicionar")),
              TextButton(
                  onPressed: () {
                    controller.removeProduct();
                  },
                  child: const Text("Remover")),
              TextButton(
                  onPressed: () {
                    controller.loadProducts();
                  },
                  child: const Text("Carregar")),
            ],
          )
        ],
      ),
    );
  }
}
