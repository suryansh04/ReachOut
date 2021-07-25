import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:community/widget/Button.dart';
import 'package:community/widget/universalform.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:dio/dio.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:geolocator/geolocator.dart';

// AIzaSyA91Cr-suDb3VDBPwLDp_ci6NOkWCKEw7k
var Username;
var price;
var work;

final firestore = FirebaseFirestore.instance;
const samePadding = EdgeInsets.symmetric(horizontal: 20.0);

var lat = 20.5937;
var lon = 78.969;
CameraPosition _initialCameraPosition() {
  return CameraPosition(
    target: LatLng(lat, lon),
    zoom: 11.5,
  );
}

Completer<GoogleMapController> _controllerGoogleMap = Completer();
GoogleMapController controllerMaps;

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {}
  @override
  void dispose() {
    super.dispose();
    controllerMaps;
  }

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    lat = await position.latitude ?? 20.5937;
    lon = await position.longitude ?? 78.9629;
    LatLng latlanPos = LatLng(lat, lon);
    CameraPosition camerapos = CameraPosition(target: latlanPos, zoom: 12);

    controllerMaps.animateCamera(CameraUpdate.newCameraPosition(camerapos));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.arrow_back,
                    size: 10.w,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Create a post !',
                    textStyle: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 25.sp),
                    speed: const Duration(milliseconds: 200),
                    textAlign: TextAlign.start,
                  ),
                ],
                repeatForever: true,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: samePadding,
                  child: CreateForm(
                    onchanged: (value) {
                      Username = value;
                    },
                    hintText: 'Name',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xff3a3380),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Padding(
                  padding: samePadding,
                  child: CreateForm(
                    hintText: 'Price',
                    prefixIcon:
                        Icon(FontAwesome.dollar, color: Color(0xff3a3380)),
                    onchanged: (value) {
                      price = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Padding(
                  padding: samePadding,
                  child: CreateForm(
                    hintText: 'Work to do',
                    prefixIcon: Icon(Icons.work, color: Color(0xff3a3380)),
                    onchanged: (value) {
                      work = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Padding(
                  padding: samePadding,
                  child: Container(
                      height: 20.h,
                      child: GoogleMap(
                        markers: _markers,
                        myLocationButtonEnabled: true,
                        onMapCreated: (GoogleMapController controller) {
                          _controllerGoogleMap.complete(controller);
                          controllerMaps = controller;

                          getCurrentLocation();
                        },
                        // markers: _markers,
                        zoomControlsEnabled: false,

                        initialCameraPosition: _initialCameraPosition(),
                      )),
                ),
                SizedBox(
                  height: 1.h,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _markers.add(
                        Marker(
                            markerId: MarkerId('id-1'),
                            position: LatLng(lat, lon)),
                      );
                    });
                  },
                  child: Container(
                    child: Text('Get current location',
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff3a3380),
                          fontSize: 15.sp,
                          decoration: TextDecoration.underline,
                        )),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Button(
                  buttonText: 'Post',
                  ontap: () {
                    firestore.collection('data').add({
                      'lat': lat,
                      'lon': lon,
                      'name': Username,
                      'price': price,
                      'work':work,  
                    });
                    // bool res =  MapsLauncher.launchCoordinates(lat, lon);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
