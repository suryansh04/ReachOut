import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

Set<Marker> markers = {};

class Cards extends StatefulWidget {
  final name;
  dynamic lat;
  dynamic lon;
  final price;
  final work;
  Cards({this.name, this.lat, this.lon, this.price, this.work});
  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  CameraPosition initialCameraPosition() {
    return CameraPosition(
      target: LatLng(widget.lat, widget.lon),
      zoom: 11.5,
    );
  }

  void onMapCreated(GoogleMapController controller) {
    int num = 2;
    String numTostring = num.toString();
    setState(() {
      markers.add(
        Marker(
            markerId: MarkerId('id-$numTostring'),
            position: LatLng(widget.lat, widget.lon)),
      );
      num++;
      numTostring = num.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      markers.add(
        Marker(
            markerId: MarkerId('id-2'),
            position: LatLng(widget.lat, widget.lon)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: EdgeInsets.all(0),
            height: 45.h,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff3a3380),
                    blurRadius: 5,
                  )
                ],
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                    child: GoogleMap(
                      // markers: _markers,
                      myLocationButtonEnabled: true,
                      // _controllerGoogleMap.complete(controller);
                      // controllerMaps = controller;

                      markers: markers,
                      zoomControlsEnabled: true,
                      zoomGesturesEnabled: true,
                      scrollGesturesEnabled: true,
                      initialCameraPosition: initialCameraPosition(),
                    )),
              ),
              SizedBox(
                height: 1.h,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text(
                          'Posted By:',
                          style: GoogleFonts.lato(
                            color: Color(0xff3a3380),
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Text(
                          widget.name,
                          style: GoogleFonts.lato(
                            color: Colors.black54,
                            fontSize: 14.sp,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Text(
                            '\$${widget.price}',
                            style: GoogleFonts.lato(
                              color: Colors.green,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text('Work to do:',
                            style: GoogleFonts.lato(
                                fontSize: 14.sp, color: Color(0xff3a3380))),
                        SizedBox(
                          width: 1.w,
                        ),
                        Text(widget.work,
                            style: GoogleFonts.lato(
                              color: Colors.black54,
                              fontSize: 14.sp,
                            )),
                      ],
                    ),
                  )
                ],
              )),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 8.5.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                    color: Color(0xff3a3380),
                  ),
                  child: Text(
                    'Accept',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
