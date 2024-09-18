import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;


class LatLocationSL extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: LatLocation (),
    );
  }
}


class LatLocation extends StatefulWidget {

  String newaddress="";

  @override
  State createState() => MyLatLocation();
}

class MyLatLocation extends State<LatLocation> {

  String currentadd = "";
  String address = "";

//  print("Received Address is : ${widget.newaddress}");


  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kgooglePlex = const CameraPosition(
      target: LatLng(28.5355, 77.3910),
      zoom: 14);

  /*double locationlat= 28.6139;
  double locationlng=77.2090;
  double clocationlat=28.5355;
  double clocationlng=77.3910;*/


  double clocationlat = 0.0;
  double clocationlng = 0.0;

  Uint8List? markerImage;
  List<Location> currentlocations = [];
  List<String> images = ['image/usericon.png'];


  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer
        .asUint8List();
  }

  List<Marker> _marker = [];

  String maptheme = "";

  @override
  void initState() {
    super.initState();

    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/dark_theme.json')
        .then((value) {
      maptheme = value;
    });

    getUserCurrentPosition().then((value) {
      value.latitude.toString();
      value.longitude.toString();

      currentadd = value.latitude.toString() + " " + value.longitude.toString();
      print("currnt Latitude and Longitude of User : $currentadd");

      clocationlat = value.latitude;
      clocationlng = value.longitude;

      getAddress(clocationlat, clocationlng);

      // getCustomMarkerIcon();
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(clocationlat, clocationlng),
                zoom: 14
            ),

            markers: Set<Marker>.of(_marker),

            myLocationEnabled: true,
            compassEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(maptheme);
              _controller.complete(controller);
            }
        ),
      ),

    );
  }

  Future<void> loadData() async {
    if (currentadd == "") {
      Fluttertoast.showToast(
          msg: "Loading",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0
      );
    }
    else {
      try {

        currentlocations = await locationFromAddress(currentadd); /*widget.newaddress*/

        currentadd = currentlocations.first.latitude.toString() + " " +
            currentlocations.first.longitude.toString();
        print("Latitude and Longitude of Curuent Address : $currentadd");

        clocationlat = currentlocations.first.latitude;
        clocationlng = currentlocations.first.longitude;

        Uint8List sourceicon = await getBytesFromAssets(images[0], 100);

        _marker.add(Marker(
            markerId: MarkerId('1'),
            icon: BitmapDescriptor.fromBytes(sourceicon),
            position: LatLng(clocationlat, clocationlng),
            infoWindow: InfoWindow(title: address)

        ));

        CameraPosition cameraPosition = CameraPosition(
          zoom: 14,
          target: LatLng(clocationlat, clocationlng),);


        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(
            CameraUpdate.newCameraPosition(cameraPosition));
        setState(() {});
      } on Exception catch (_) {
        print("No Location Available Now");

        Fluttertoast.showToast(
            msg: "No Location Available Now",
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

    Future<Position> getUserCurrentPosition() async {
      await Geolocator.requestPermission().then((value) {

      }).onError((error, stackTrace) {
        print("current location errror : " + error.toString());
      });

      return await Geolocator.getCurrentPosition();
    }

  getAddress(lat,lon) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
    setState(() {
      //  address =placemarks[0].street! + " " + placemarks[0].country!;
      address = placemarks[0].street.toString()+" "+placemarks[0].subLocality.toString()
          +" "+placemarks[0].locality.toString()+" "+placemarks[0].postalCode.toString()
          +" "+placemarks[0].country.toString();

      print("Current Address is : "+address);

    });
  }


  }
