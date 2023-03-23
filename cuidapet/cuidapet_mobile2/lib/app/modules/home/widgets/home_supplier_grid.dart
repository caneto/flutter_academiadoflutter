import 'package:flutter/material.dart';

import '../../../core/ui/extensions/theme_extension.dart';
import '../../../models/supplier_nearby_me_model.dart';

class HomeSupplierGridItemWidget extends StatelessWidget {
 
  final SupplierNearbyMeModel supplier;

  const HomeSupplierGridItemWidget({
    required this.supplier,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    var id = supplier.id;

    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed('/supplier/', arguments: supplier.id),
      child: Stack(
        children: [
          Card(
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            margin:
                const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
            child: SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      supplier.name,
                      textAlign: TextAlign.justify,
                      style: context.textTheme.titleSmall,
                    ),
                    Text(
                      '${supplier.distance.toStringAsFixed(2)} km',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[200],
            ),
          ),
          Positioned(
            top: 4,
            left: 0,
            right: 0,
            child: Center(
              child: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(supplier.logo),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
