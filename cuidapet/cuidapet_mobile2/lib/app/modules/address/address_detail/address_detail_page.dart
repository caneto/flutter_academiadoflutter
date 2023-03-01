import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

import '../../../core/ui/extensions/theme_extension.dart';
import '../../../core/ui/widgets/app_default_button.dart';
import '../../../entities/address_entity.dart';
import '../../../models/place_model.dart';
import 'address_detail_controller.dart';

part 'widgets/google_map_widget.dart';
part 'widgets/save_address_button.dart';

class AddressDetailPage extends StatefulWidget {
  final PlaceModel place;

  const AddressDetailPage({
    required this.place,
    super.key,
  });

  @override
  State<AddressDetailPage> createState() => _AddressDetailPageState();
}

class _AddressDetailPageState extends State<AddressDetailPage> {
  final _additionInfoEC = TextEditingController();
  final _controller = Modular.get<AddressDetailController>();
  late final ReactionDisposer addressDisposer;

  @override
  void initState() {
    super.initState();
    addressDisposer = reaction((_) => _controller.address, (address) {
      if (address != null) {
        Navigator.pop<AddressEntity>(context, address);
      }
    });
  }

  @override
  void dispose() {
    _additionInfoEC.dispose();
    addressDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final address = widget.place.address;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: context.primaryColor),
        elevation: 0,
      ),
      body: ListView(
        children: [
          Text(
            'Confirme seu endereço',
            textAlign: TextAlign.center,
            style: context.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _GoogleMapWidget(
            lat: widget.place.latitude,
            lng: widget.place.longitude,
            address: address,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              initialValue: address,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Endereço',
                suffixIcon: IconButton(
                  onPressed: () => Navigator.of(context).pop(widget.place),
                  icon: const Icon(Icons.edit),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'Complemento'),
              controller: _additionInfoEC,
            ),
          ),
          _SaveAddressButton(
            onPressed: () =>
                _controller.saveAddress(widget.place, _additionInfoEC.text),
          ),
        ],
      ),
    );
  }
}
