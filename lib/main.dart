import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
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
    var a = FirebaseFirestore.instance
        .collection('ubicacionRepartidor')
        .doc('IXvTa9j5pZbYjpC0Ttgh0OXNcCD3')
        .snapshots();
    var b = FirebaseFirestore.instance.collection('location').snapshots();

    return SafeArea(
      child: StreamBuilder<DocumentSnapshot>(
        stream: a,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            //Extract the location from document
            print("/-\\");
            var data1 = snapshot.data?.get("ubicacionActual");
            print(data1);

            Direccion ubicacionActualRepartidor =
                Direccion.fromMap(snapshot.data?.get("ubicacionActual"));
            print(
                "${ubicacionActualRepartidor.latitud},${ubicacionActualRepartidor.longitud}");
            print("====");
            /* print(snapshot.data!.docs.length);
            var data = snapshot.data;
            print(data!.docs.first.get('location').toString());*/
            // GeoPoint location = snapshot.data!.first.get("location");
            //  GeoPoint location = data1['location'];
            // Check if location is valid
            if (data1.toString().isEmpty) {
              return Text("There was no location data");
            }

            // Remove any existing markers
            markers.clear();

            final latLng = LatLng(ubicacionActualRepartidor.latitud,
                ubicacionActualRepartidor.longitud);

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
                  zoom: 15,
                  target: LatLng(ubicacionActualRepartidor.latitud,
                      ubicacionActualRepartidor.longitud)),
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
