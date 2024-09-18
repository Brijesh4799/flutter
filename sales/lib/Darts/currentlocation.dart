import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/apis.dart';

import '../main.dart';

import 'package:http/http.dart' as http;


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


  double clocationlat = 0.0;
  double clocationlng = 0.0;

  String maptheme = "";
  List<Marker> _marker=[];
  List<String> images = ['image/usericon.png'];

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer
        .asUint8List();
  }

  @override
  void initState() {
    super.initState();

    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/dark_theme.json')
        .then((value) {
      maptheme = value;
    });

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  Container(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(clocationlat, clocationlng),
              zoom: 14
          ),
          markers: Set<Marker>.of(_marker),
          myLocationEnabled: true,
          compassEnabled: true,
          onMapCreated: (GoogleMapController controller){
            controller.setMapStyle(maptheme);
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
        clocationlat = locations.first.latitude;
        clocationlng = locations.first.longitude;
        print("Latitude and Longitude : $address");

        Uint8List sourceicon = await getBytesFromAssets(images[0], 100);

        _marker.add(Marker(
            markerId: MarkerId('1'),
            icon: BitmapDescriptor.fromBytes(sourceicon),
            position: LatLng(clocationlat, clocationlng),
            infoWindow: InfoWindow(title: widget.newaddress)
        ));

        CameraPosition cameraPosition = CameraPosition(
            zoom: 14,
            target: LatLng(clocationlat, clocationlng));

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