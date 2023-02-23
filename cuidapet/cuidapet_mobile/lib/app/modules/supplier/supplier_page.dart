import 'package:flutter/material.dart';

import '../../core/ui/extensions/theme_extension.dart';
import 'widgets/supplier_detail.dart';
import 'widgets/supplier_service_widget.dart';

class SupplierPage extends StatelessWidget {
  const SupplierPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Fazer agendamento'),
        icon: const Icon(Icons.schedule),
        backgroundColor: context.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
              background: Image.network(
                'https://veja.abril.com.br/wp-content/uploads/2017/01/cao-labrador-3-copy.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
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
