import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaConPolyline extends StatelessWidget {
  const MapaConPolyline(
      {Key? key,
      required this.targetinitialCameraPosition,
      required this.onMapCreated,
      required this.markers,
      required this.polylines})
      : super(key: key);
  final LatLng targetinitialCameraPosition;
  final void Function(GoogleMapController)? onMapCreated;
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition:
          CameraPosition(target: targetinitialCameraPosition, zoom: 15),
      myLocationEnabled: true,
      tiltGesturesEnabled: true,
      compassEnabled: true,
      scrollGesturesEnabled: true,
      zoomGesturesEnabled: true,
      onMapCreated: onMapCreated,
      markers: markers,
      polylines: polylines,
    );
  }
}
