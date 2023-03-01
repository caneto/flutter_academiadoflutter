import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/life_cycle/page_life_cycle_state.dart';
import '../core/auth/auth_store.dart';
import 'home_controller.dart';
import 'widgets/home_appbar.dart';
import 'widgets/home_persistent_header_delegate.dart';
import 'widgets/home_supplier_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends PageLifeCycleState<HomeController, HomePage> {
  late ScrollController _scrollController;
  final _containerHeight = ValueNotifier<double>(0);

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
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          HomeAppBar(controller),
          SliverPersistentHeader(
            delegate: HomePersistentHeaderDelegate(controller),
            pinned: true,
          ),
          Observer(
            builder: (_) => SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: controller.suppliersByAddress.length,
                (_, index) => HomeSupplierListItemWidget(
                  supplier: controller.suppliersByAddress[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
