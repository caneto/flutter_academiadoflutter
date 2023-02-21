import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/helpers/debouncer.dart';
import '../../core/life_cycle/page_life_cycle_state.dart';
import '../../core/ui/extensions/screen_size_extension.dart';
import '../../core/ui/extensions/theme_extension.dart';
import '../core/auth/auth_store.dart';
import 'home_controller.dart';

part 'widgets/home_appbar.dart';
part 'widgets/home_address_widget.dart';
part 'widgets/home_categories_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (_, __) => [
          HomeAppBar(controller),
          SliverToBoxAdapter(child: _HomeAddressWidget(controller: controller)),
          //SliverToBoxAdapter(
          //  child: _HomeCategoriesWidget(controller: controller),
          //),
        ],
        body: Container(), //_HomeSupplierTab(controller: controller),
      ),
    );
  }
}
