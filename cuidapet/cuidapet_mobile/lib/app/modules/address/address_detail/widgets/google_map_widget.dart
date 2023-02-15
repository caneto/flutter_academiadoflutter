part of '../address_detail_page.dart';

class _GoogleMapWidget extends StatelessWidget {
  final double lat;
  final double lng;
  final String address;

  const _GoogleMapWidget({
    required this.lat,
    required this.lng,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    final latLng = LatLng(lat, lng);

    return SizedBox(
      height: 0.5.sh,
      child: GoogleMap(
        gestureRecognizers: {}..add(
            const Factory<EagerGestureRecognizer>(EagerGestureRecognizer.new),
          ),
        initialCameraPosition: CameraPosition(target: latLng, zoom: 16),
        markers: {
          Marker(
            markerId: const MarkerId('Address ID'),
            position: latLng,
            infoWindow: InfoWindow(title: address),
          ),
        },
      ),
    );
  }
}
