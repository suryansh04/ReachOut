import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community/screens/post.dart';
import 'package:community/screens/signup.dart';
import 'package:community/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

User user;
dynamic userName = 'musk';

Set<Marker> _markers = {};
void _onMapCreated(GoogleMapController controller) {}

class HomePage extends StatefulWidget { 
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff3a3380),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PostScreen()));
          },
          child: Icon(Icons.add),
        ),
        body: Column(children: [
          Expanded(
            child: Container(
              color: Color(0xff3a3380),
              child: Stack(
                children: [
                  Center(
                    child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.1), BlendMode.modulate),
                        child: SvgPicture.asset('assets/community.svg')),
                  ),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Welcome to lendly \n',
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 22.sp,
                            )),
                        TextSpan(
                            text: 'Help your community',
                            style: GoogleFonts.lato(
                                color: Colors.grey, fontSize: 13.sp)),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // -----------------------------------------------Body-----------------------------------------
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: ListView(padding: EdgeInsets.all(0.0), children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Posts',
                        style: GoogleFonts.lato(
                          color: Color(0xff3a3380),
                          fontSize: 22.sp,
                        ),
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: firestore.collection('data').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final receiveData = snapshot.data.docs;
                          List<Widget> showCardWidgets = [];
                          for (var datas in receiveData) {
                            dynamic lonReceived = datas.get('lon');
                            dynamic latReceived = datas.get('lat');
                            final nameReceived = datas.get('name');
                            final priceReceived = datas.get('price');
                            final workReceived = datas.get('work');
                            showCardWidgets.add(Cards(
                                name: nameReceived,
                                price: priceReceived,
                                work: workReceived,
                                lat: latReceived,
                                lon: lonReceived));
                          }
                          return Column(
                            children: showCardWidgets,
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                  ],
                ),
              ]),
            ),
          )
        ]));
  }
}

void getCurrentUser() async {
  try {
    final Currentuser = await _auth.currentUser;
    print(Currentuser.email);
  } catch (e) {
    print(e);
  }
}

