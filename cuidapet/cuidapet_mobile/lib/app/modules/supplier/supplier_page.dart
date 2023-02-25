import 'dart:developer';

import 'package:flutter/material.dart';
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
    print(controller.supplierModel);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => log('Fazer agendamento'),
        label: const Text('Fazer agendamento'),
        icon: const Icon(Icons.schedule),
        backgroundColor: context.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomScrollView(
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
                        'Clínica central ABC',
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
                'https://veja.abril.com.br/wp-content/uploads/2017/01/cao-labrador-3-copy.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Nil(),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SupplierDetail(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 200,
              (context, index) {
                return const SupplierServiceWidget();
              },
            ),
          )
        ],
      ),
    );
  }
}
