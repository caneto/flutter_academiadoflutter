import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nil/nil.dart';

import '../../core/life_cycle/page_life_cycle_state.dart';
import '../../core/ui/extensions/theme_extension.dart';
import 'supplier_controller.dart';
import 'widgets/supplier_detail.dart';
import 'widgets/supplier_service_widget.dart';

class SupplierPage extends StatefulWidget {
  final int _supplierId;

  const SupplierPage({required int supplierId, super.key})
      : _supplierId = supplierId;

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState
    extends PageLifeCycleState<SupplierController, SupplierPage> {
  late ScrollController _scrollController;
  bool sliverCollapsed = false;
  final _sliverCollapsedNotifier = ValueNotifier(false);

  @override
  Map<String, dynamic>? get params => {'supplierId': widget._supplierId};

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset > 180 &&
          !_scrollController.position.outOfRange) {
        _sliverCollapsedNotifier.value = true;
      } else if (_scrollController.offset <= 180) {
        _sliverCollapsedNotifier.value = false;
      }
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
      floatingActionButton: Observer(
        builder: (_) {
          return AnimatedOpacity(
            duration: const Duration(microseconds: 300),
            opacity: controller.totalServicesSelected > 0 ? 1 : 0,
            child: FloatingActionButton.extended(
              onPressed: controller.goToSchedule,
              label: const Text('Fazer agendamento'),
              icon: const Icon(Icons.schedule),
              backgroundColor: context.primaryColor,
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Observer(
        builder: (_) {
          final supplier = controller.supplierModel;

          if (supplier == null) {
            return const Text('Busncado dados do fornecedor');
          }

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: ValueListenableBuilder<bool>(
                    valueListenable: _sliverCollapsedNotifier,
                    builder: (_, collapsed, __) => collapsed
                        ? Text(
                            supplier.name,
                            style: context.textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : const Nil(),
                  ),
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    StretchMode.fadeTitle,
                  ],
                  background: Image.network(
                    supplier.logo,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Nil(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SupplierDetail(
                  supplier: supplier,
                  controller: controller,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Serviços (${controller.totalServicesSelected} selecionado${controller.totalServicesSelected > 1 ? 's' : ''})',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: controller.supplierServices.length,
                  (context, index) {
                    final service = controller.supplierServices[index];
                    return SupplierServiceWidget(
                      service: service,
                      supplierController: controller,
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
