import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';

import '../../core/life_cycle/page_life_cycle_state.dart';
import '../../core/mixins/location_mixin.dart';
import '../../core/ui/extensions/theme_extension.dart';
import '../../models/place_model.dart';
import 'address_controller.dart';
import 'widgets/address_search_widget/address_search_controller.dart';

part 'widgets/address_item.dart';
part 'widgets/address_search_widget/address_search_widget.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState
    extends PageLifeCycleState<AddressController, AddressPage>
    with LocationMixin {
      
  final _reactorDisposers = <ReactionDisposer>[];

  @override
  void initState() {
    super.initState();
    final reactionService = reaction<bool>(
      (_) => controller.locationServiceUnavailable,
      (locationService) {
        if (locationService) {
          showDialogLocationServiceUnavailable();
        }
      },
    );

    final reactionLocationPermission = reaction<LocationPermission?>(
      (_) => controller.locationPermission,
      (locationPermission) {
        if (locationPermission != null &&
            locationPermission == LocationPermission.denied) {
          showDialogLocationDenied(tryAgain: controller.getMyLocation);
        } else if (locationPermission != null &&
            locationPermission == LocationPermission.deniedForever) {
          showDialogLocationDeniedForever();
        }
      },
    );

    _reactorDisposers.addAll([reactionService, reactionLocationPermission]);
  }

  @override
  void dispose() {
    for (final disposer in _reactorDisposers) {
      disposer();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.wasAddressSelected,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: context.primaryColorDark),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              children: [
                Text(
                  'Adiciona ou escolha um endereço',
                  style: context.textTheme.headlineMedium?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Observer(
                  builder: (_) => _AddressSearchWidget(
                    key: UniqueKey(),
                    onAddressSelected: controller.goToAddressDetail,
                    place: controller.placeModel,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  onTap: controller.getMyLocation,
                  leading: const CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 30,
                    child: Icon(
                      Icons.near_me,
                      color: Colors.white,
                    ),
                  ),
                  title: const Text(
                    'Localização Atual',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                const SizedBox(
                  height: 20,
                ),
                Observer(
                  builder: (_) {
                    return Column(
                      children: controller.addresses
                          .map(
                            (e) => _AddressItem(
                              additionalInfo: e.additionalInfo,
                              address: e.address,
                              onTap: () => controller.selectAddress(e),
                            ),
                          )
                          .toList(),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
