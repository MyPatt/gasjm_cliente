import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'geolocation',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => HomeSampleState();
}

class HomeSampleState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text("Ugh oh! Something went wrong");

          if (!snapshot.hasData) return Text("Got no data :(");

          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done)
            return HomeView();

          return Text("Loading please...");
        },
      ),
    );
  }
}

const double ZOOM = 16;

class HomeView extends StatelessWidget {
  static GoogleMapController? _googleMapController;
  Set<Marker> markers = Set();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('Location').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            //Extract the location from document
            print("/-\\");

            var data1 =
                snapshot.data!.docs.first.data();
            print(data1['location'].toString());
            print("====");
           /* print(snapshot.data!.docs.length);
            var data = snapshot.data;
            print(data!.docs.first.get('location').toString());*/
            // GeoPoint location = snapshot.data!.first.get("location");
            GeoPoint location = data1['location'];
            // Check if location is valid
            if (location == null) {
              return Text("There was no location data");
            }

            // Remove any existing markers
            markers.clear();

            final latLng = LatLng(location.latitude, location.longitude);

            // Add new marker with markerId.
            markers
                .add(Marker(markerId: MarkerId("location"), position: latLng));

            // If google map is already created then update camera position with animation
            _googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                target: latLng,
                zoom: ZOOM,
              ),
            ));

            return GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(location.latitude, location.longitude)),
              // Markers to be pointed
              markers: markers,
              onMapCreated: (controller) {
                // Assign the controller value to use it later
                _googleMapController = controller;
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
