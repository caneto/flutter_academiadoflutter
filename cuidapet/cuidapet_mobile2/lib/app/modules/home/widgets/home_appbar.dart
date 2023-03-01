import 'package:flutter/material.dart';

import '../../../core/helpers/debouncer.dart';
import '../../../core/ui/extensions/screen_size_extension.dart';
import '../../../core/ui/extensions/theme_extension.dart';
import '../home_controller.dart';

class HomeAppBar extends SliverAppBar {
  HomeAppBar(
    HomeController controller, {
    super.key,
    super.expandedHeight = 100,
    super.collapsedHeight = 100,
    super.elevation = 0,
    super.pinned = true,
    super.iconTheme = const IconThemeData(color: Colors.black),
  }) : super(flexibleSpace: _CuidapetAppBar(controller: controller));
}

class _CuidapetAppBar extends StatelessWidget {
  final HomeController controller;

  const _CuidapetAppBar({required this.controller});

  static final _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(color: Colors.grey[200]!),
    );

    return AppBar(
      elevation: 0,
      centerTitle: true,
      flexibleSpace: Stack(
        children: [
          Container(height: 110.h, color: context.primaryColor),
          Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              elevation: 4,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: SizedBox(
                width: 0.9.sw,
                child: TextFormField(
                  onChanged: (value) => _debouncer
                      .run(() => controller.filterSupplierBySearchText(value)),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon:
                        const Icon(Icons.search, size: 25, color: Colors.grey),
                    border: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      title: const Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: Text('Cuidapet'),
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
    );
  }
}
