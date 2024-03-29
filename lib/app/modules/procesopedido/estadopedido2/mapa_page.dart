import 'dart:async';
 
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class LocationTrackerBlog extends StatefulWidget {
  const LocationTrackerBlog({Key? key}) : super(key: key);

  @override
  State<LocationTrackerBlog> createState() => _LocationTrackerBlogState();
}

class _LocationTrackerBlogState extends State<LocationTrackerBlog> {
  final MapShapeLayerController _layerController = MapShapeLayerController();
  final TextEditingController _currentLocationTextController =
      TextEditingController();
  final TextEditingController _destinationLocationTextController =
      TextEditingController();

  double? _distanceInMiles;

  Position? _currentPosition, _destinationPosition;
  StreamSubscription<Position>? _positionStream;

  @override
  void dispose() {
    _layerController.dispose();
    _currentLocationTextController.dispose();
    _destinationLocationTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF096770),
      body: SafeArea(
        child: Column(
          children: [
            //Title widget
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Location Tracker',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                //Current location text field.
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _currentLocationTextController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 10, right: 3, top: 3, bottom: 3),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        hintText: 'Current location',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                //Current location clickable icon.

                IconButton(
                  icon: const Icon(
                    Icons.my_location,
                    color: Colors.white,
                  ),
                  tooltip: 'My location',
                  onPressed: () async {
                    _currentPosition = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high);
                    List<Placemark> addresses = await placemarkFromCoordinates(
                        _currentPosition!.latitude,
                        _currentPosition!.longitude);
                    _currentLocationTextController.text = addresses[0].name!;
                    _layerController.insertMarker(0);
                  },
                )
              ],
            ),
            Row(
              children: [
                //Destination location text field.
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _destinationLocationTextController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.only(
                            left: 10, right: 3, top: 3, bottom: 3),
                        hintText: 'Enter the destination',
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                //Destination location clickable icon.

                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  tooltip: 'Search',
                  onPressed: () async {
                    List<Location> places = await locationFromAddress(
                        _destinationLocationTextController.text);
                    _destinationPosition = Position(
                        longitude: places[0].longitude,
                        latitude: places[0].latitude,
                        timestamp: places[0].timestamp,
                        accuracy: 1,
                        altitude: 0,
                        heading: 0,
                        speed: 0,
                        speedAccuracy: 0);

                    _layerController.insertMarker(1);

                    //1 mile = 0.000621371 * meters
                    setState(() {
                      _distanceInMiles = Geolocator.distanceBetween(
                              _currentPosition!.latitude,
                              _currentPosition!.longitude,
                              _destinationPosition!.latitude,
                              _destinationPosition!.longitude) *
                          0.000621371;
                    });
                  },
                )
              ],
            ),
            //Maps widget container
            Container(
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SfMaps(
                    layers: [
                      MapShapeLayer(
                        controller: _layerController,
                        markerBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            //current position
                            return MapMarker(
                                latitude: _currentPosition!.latitude,
                                longitude: _currentPosition!.longitude,
                                child: Icon(Icons.location_on));
                          } else if (index == 1) {
                            //destination position
                            return MapMarker(
                                latitude: _destinationPosition!.latitude,
                                longitude: _destinationPosition!.longitude,
                                child: Icon(Icons.location_on));
                          } else if (index == 2) {
                            //flight current position
                            return MapMarker(
                              latitude: _currentPosition!.latitude,
                              longitude: _currentPosition!.longitude,
                              child: Transform.rotate(
                                  angle: 45, child: Icon(Icons.flight)),
                            );
                          }
                          return const MapMarker(latitude: 0, longitude: 0);
                        },
                        source: const MapShapeSource.asset(
                          "assets/world_map.json",
                          shapeDataField: "name",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //Widget for starting location and stopping location
            //tracking. It also shows the current distance between the
            //current and destination location in miles.
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text:
                                  '${_distanceInMiles?.toStringAsFixed(2) ?? '-'} miles.',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black)),
                          TextSpan(
                              text: '${'-'} miles.',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black))
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        OutlinedButton(
                          child: Text('Navigate'),
                          // textColor: Colors.black,
                          onPressed: () async {
                            _layerController.insertMarker(2);
                            _positionStream = Geolocator.getPositionStream()
                                .listen((Position position) {
                              _currentPosition = position;
                              //1 mile = 0.000621371 * meters
                              setState(() {
                                _distanceInMiles = Geolocator.distanceBetween(
                                        _currentPosition!.latitude,
                                        _currentPosition!.longitude,
                                        _destinationPosition!.latitude,
                                        _destinationPosition!.longitude) *
                                    0.000621371;
                              });
                              _layerController.updateMarkers([2]);
                            });
                          },
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        OutlinedButton(
                          child: Text('Remove tracker'),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
