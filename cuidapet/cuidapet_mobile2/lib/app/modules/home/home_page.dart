import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/helpers/debouncer.dart';
import '../../core/life_cycle/page_life_cycle_state.dart';
import '../core/auth/auth_store.dart';
import 'home_controller.dart';
import 'widgets/home_address_widget.dart';
import 'widgets/home_categories_widget.dart';
import 'widgets/home_supplier_grid.dart';
import 'widgets/home_supplier_list_item.dart';
import 'widgets/home_supplier_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends PageLifeCycleState<HomeController, HomePage> {
  late ScrollController _scrollController;
  final _containerHeight = ValueNotifier<double>(0);

  static final _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      _containerHeight.value = _scrollController.offset > 56 ? 100 : 0;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(AppBar().preferredSize.height),
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              ListTile(
                title: const Text('Sair'),
                onTap: () async {
                  await Modular.get<AuthStore>().logout();

                  Modular.to.navigate('/auth/');
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          HomeAddressWidget(controller: controller),
          HomeCategoriesWidget(controller: controller),
          HomeSupplierTab(controller: controller),
          Expanded(
            child: Observer(
              builder: (_) => AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: controller.suppliersPageType == SupplierPageType.list
                    ? ListView.builder(
                        itemCount: controller.suppliersByAddress.length,
                        itemBuilder: (_, index) {
                          return HomeSupplierListItemWidget(
                            supplier: controller.suppliersByAddress[index],
                          );
                        },
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 240,
                          childAspectRatio: 6 / 5,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: controller.suppliersByAddress.length,
                        itemBuilder: (_, index) {
                          return HomeSupplierGridItemWidget(
                            supplier: controller.suppliersByAddress[index],
                          );
                        },
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _appBar(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 40),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                // Background
                color: Theme.of(context).primaryColor,
                height: height + 25,
                width: MediaQuery.of(context).size.width,
                // Background
                child: const Padding(
                  padding: EdgeInsets.only(top: 8, left: 120),
                  child: Text(
                    'Cuidapet',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(),
              Positioned(
                top: 50,
                left: 20,
                right: 20,
                child: AppBar(
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(color: Colors.green),
                  elevation: 0,
                  centerTitle: true,
                  title: TextFormField(
                    onChanged: (value) => _debouncer.run(
                      () => controller.filterSupplierBySearchText(value),
                    ),
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Busca',
                      suffixIcon: Icon(
                        Icons.search,
                        size: 25,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: controller.goToAddress,
                      tooltip: 'Alterar endereço',
                      icon: const Icon(
                        Icons.location_on,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
