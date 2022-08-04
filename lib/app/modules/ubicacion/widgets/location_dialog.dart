import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart'; 

class AppState extends StatefulWidget {
  @override
  AppPermission createState() => AppPermission();
}

class AppPermission extends State<AppState> {
  Future<void> requestCameraPermission() async {
    final serviceStatus = await Permission.camera.isGranted;

   // bool isCameraOn = serviceStatus == ServiceStatus.enabled;

    final status = await Permission.camera.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }

  Future<void> requestLocationPermission() async {
    //final serviceStatusLocation = await Permission.locationWhenInUse.isGranted ;

    //bool isLocation = serviceStatusLocation == ServiceStatus.enabled;

    final status = await Permission.locationWhenInUse.request();
    print("ddddddddddddd" + status.isDenied.toString());
    /*
    if (status == PermissionStatus.granted) {
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }*/
  }

  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.lightBlue,
              padding:  const EdgeInsets.all(8),
              textStyle:  const TextStyle(fontSize: 20),
            ),
            child:  const Text('Request Runtime Camera Permission'),
            onPressed: requestCameraPermission,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.lightBlue,
              padding: const EdgeInsets.all(8),
              textStyle: const TextStyle(fontSize: 20),
            ),
            child: const Text('Request Runtime Location Permission'),
            onPressed: requestLocationPermission,
          ),
        ),
      ],
    ));
  }
}
