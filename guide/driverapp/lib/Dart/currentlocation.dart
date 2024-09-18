import 'dart:async';
import 'dart:convert';


import 'package:driverapp/Dart/alertdetail.dart';
import 'package:driverapp/Dart/pendingduties.dart';
import 'package:driverapp/Dart/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/apis.dart';
import '../Models/AlertModel.dart';
import '../Models/NotificationModel.dart';
import '../Providers/pickeralert.dart';
import '../Providers/pickeralert.dart';
import '../main.dart';
import 'BottomNavAlert.dart';
import 'BottomNavComplete.dart';
import 'BottomNavList.dart';
import 'BottomNavPending.dart';
import 'completeduties.dart';
import 'home.dart';
import 'login.dart';
import 'package:http/http.dart' as http;

import 'mylist.dart';


/*class CurrentLocationSL extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: CurrentLocation(),
    );
  }
}*/


class CurrentLocation extends StatefulWidget {

  String newaddress="";

  CurrentLocation({Key? mykey, required this.newaddress}) : super(key: mykey);

  @override
  State createState() => MyCurrentLocation();
}

class MyCurrentLocation extends State<CurrentLocation> {

  String address="";
  String add="The Corenthum, Sector 62, Noida, Uttar Pradesh, India";

//  print("Received Address is : ${widget.newaddress}");


  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kgooglePlex = const CameraPosition(
      target: LatLng(28.7296 , 77.2046),
      zoom: 18);

  List<Marker> _marker=[];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  Container(
        child: GoogleMap(
          initialCameraPosition: _kgooglePlex,
          markers: Set<Marker>.of(_marker),
          myLocationEnabled: true,
          compassEnabled: true,
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);},
        ),
      ),

    );
  }

  Future<void> loadData() async {

    if(widget.newaddress==""){
      Fluttertoast.showToast(
          msg:  "No Location Available Now",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0
      );

    }
    else{

      try {
        List<Location> locations = await locationFromAddress(widget.newaddress);

        Fluttertoast.showToast(
            msg:  widget.newaddress,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 4,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 14.0
        );

        address = locations.first.latitude.toString() +" "+ locations.first.longitude.toString();
        print("Latitude and Longitude : $address");

        _marker.add(Marker(
            markerId: MarkerId('2'),
            position: LatLng(locations.first.latitude, locations.first.longitude),
            infoWindow: InfoWindow(title: widget.newaddress)
        ));

        CameraPosition cameraPosition = CameraPosition(
            zoom: 14,
            target: LatLng(locations.first.latitude, locations.first.longitude));

        final GoogleMapController controller =await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        setState(() {

        });

      } on Exception catch (_) {
        print("No Location Available Now");

        Fluttertoast.showToast(
            msg:  "No Location Available Now",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 4,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 14.0
        );

      }

    }


  }
}