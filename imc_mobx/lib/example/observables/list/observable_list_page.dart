import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'obervable_list_controller.dart';

class ObservableListPage extends StatefulWidget {
  const ObservableListPage({Key? key}) : super(key: key);

  @override
  State<ObservableListPage> createState() => _ObservableListPageState();
}

class _ObservableListPageState extends State<ObservableListPage> {
  final controller = ObervableListController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Observable List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Observer(
              builder: (_) {
                return ListView.builder(
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    final productName = controller.products[index].name;
                    return CheckboxListTile(
                      value: false,
                      onChanged: (_) {},
                      title: Text(productName),
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
