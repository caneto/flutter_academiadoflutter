import 'package:flutter/material.dart';
import 'package:nil/nil.dart';

import '../../../core/ui/extensions/screen_size_extension.dart';
import '../../../core/ui/extensions/theme_extension.dart';
import '../../../models/supplier_nearby_me_model.dart';

class HomeSupplierListItemWidget extends StatelessWidget {
  final SupplierNearbyMeModel supplier;

  const HomeSupplierListItemWidget({
    required this.supplier,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed('/supplier/', arguments: supplier.id),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 30),
              width: 1.sw,
              height: 80.h,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            supplier.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 16),
                              const SizedBox(width: 5),
                              Text(
                                '${supplier.distance.toStringAsFixed(2)} km',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: CircleAvatar(
                      backgroundColor: context.primaryColor,
                      radius: 15,
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                border: Border.fromBorderSide(
                  BorderSide(color: Colors.transparent),
                ),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.fromBorderSide(
                    BorderSide(color: Colors.grey[100]!, width: 5),
                  ),
                  color: Colors.grey,
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  image: DecorationImage(
                    onError: (_, __) => const Nil(),
                    image: NetworkImage(supplier.logo),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
