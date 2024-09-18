import 'dart:async';
import 'dart:convert';


import 'package:driverapp/Dart/alertdetail.dart';
import 'package:driverapp/Dart/pendingduties.dart';
import 'package:driverapp/Dart/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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


class GoogleMapsSL extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: GoogleMaps(),
    );
  }

}

class GoogleMaps extends StatefulWidget {

  @override
  State createState() => MyGoogleMaps();
}

class MyGoogleMaps extends State<GoogleMaps> {

  String address="";
  String Add="";

  Completer<GoogleMapController> _controller = Completer();
  
  static final CameraPosition _kgooglePlex = const CameraPosition(
      target: LatLng(28.7296 , 77.2046),
  zoom: 14.4746);
  
  List<Marker> _marker=[];
  List<Marker> _list= [
        Marker(markerId: MarkerId("1"),
        position:LatLng(28.7296 , 77.2046),
          infoWindow: InfoWindow(
            title: "Current Location"
          )
        )
  ];

  @override
  void initState() {
    super.initState();
   // _marker.addAll(_list);

    loadData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(children: [

        SizedBox(height: 50,),

       GestureDetector(onTap: () async {
         List<Location> locations = await locationFromAddress("The Corenthum, Sector 62, Noida, Uttar Pradesh, India");
         List<Placemark> placemarks = await placemarkFromCoordinates(28.7296 , 77.2046);

         setState(() {
           address = locations.last.latitude.toString() +" "+ locations.last.longitude.toString();
           print("Latitude and Longitude : $address");

         //  Add = placemarks.reversed.first.subLocality.toString()+""+placemarks.reversed.first.locality.toString();
        //   print("Address is  : $Add");
         });
       },
           child: Container(
         child: Center(
             child: Text("Convert",style: TextStyle(color: Colors.black,fontSize: 14),
             )),)),

        SizedBox(height: 50,),

        Container(
          width: MediaQuery.of(context).size.width,
          height: 500,
          child: GoogleMap(
            initialCameraPosition: _kgooglePlex,
            markers: Set<Marker>.of(_marker),
            myLocationEnabled: true,
            compassEnabled: true,
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);},
          ),
        ),


      ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
         loadData();
        },
        child: Icon(Icons.local_activity),
      ),
      
    );
  }

  Future<Position> getUserCurrentLocation() async{

    await Geolocator.requestPermission().then((value) {

    }).onError((error, stackTrace) {
      print("Error" +error.toString());
    });

    return await Geolocator.getCurrentPosition();

  }

  void loadData() {
    getUserCurrentLocation().then((value) async {
      print("my Current Location");
      print(value.latitude.toString()+" "+value.longitude.toString());

      _marker.add(Marker(
          markerId: MarkerId('2'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(title: "CurrentLocation")
      ));

      CameraPosition cameraPosition = CameraPosition(
          zoom: 14,
          target: LatLng(value.latitude, value.longitude));

      final GoogleMapController controller =await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {

      });
    });
  }

}
