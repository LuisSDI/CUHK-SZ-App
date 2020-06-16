import 'package:cuhkszapp/MainPages/DiscoverPages/foundation_screen.dart';
import 'package:cuhkszapp/MainPages/DiscoverPages/sse_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'DiscoverPages/hss_screen.dart';
import 'DiscoverPages/lhs_screen.dart';
import 'DiscoverPages/sme_screen.dart';

class DiscoverTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return SafeArea(
      top: false,
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(
              left: scaler.getWidth(7), right: scaler.getWidth(7)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //Discover Text
                Padding(
                  padding: EdgeInsets.only(top: scaler.getWidth(7)),
                  child: Container(
                    height: scaler.getHeight(5),
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "Majors,",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 36,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
                //Subtitle Text
                Container(
                  height: scaler.getHeight(3),
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "Choose what you love",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                        fontSize: 23,
                        color: Colors.black,
                      )),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    //Foundation Courses
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: scaler.getHeight(2.5)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FoundationScreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xff6747CD),
                                    Color(0x8C3300D6)
                                  ]),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x80000000),
                                  blurRadius: 4.0, // soften the shadow
                                  spreadRadius: 0, //extend the shadow
                                  offset: Offset(
                                    0, // Move to right 10  horizontally
                                    6, // Move to bottom 10 Vertically
                                  ),
                                )
                              ]),
                          child: Container(
                            padding: EdgeInsets.all(scaler.getHeight(1)),
                            alignment: Alignment.center,
                            child: Text(
                              'Foundation Courses',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                //height: .5,
                                fontSize: 23,
                                color: Colors.white,
                              )),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                          top: scaler.getHeight(1),
                          bottom: scaler.getHeight(1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          //SSE Button
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SSEScreen()));
                            },
                            child: Container(
                              height: scaler.getHeight(18),
                              width: scaler.getHeight(18),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xff6747CD),
                                        Color(0x8C3300D6)
                                      ]),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x80000000),
                                      blurRadius: 4.0, // soften the shadow
                                      spreadRadius: 0, //extend the shadow
                                      offset: Offset(
                                        0, // Move to right 10  horizontally
                                        6, // Move to bottom 10 Vertically
                                      ),
                                    )
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: scaler.getHeight(6),
                                    child: FittedBox(
                                      child: Icon(
                                        FontAwesome.gears,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: scaler.getHeight(4.2),
                                    child: Text(
                                      'SSE',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              //height: .5,
                                              fontSize: 23,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          //SME Button
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SMEScreen()));
                            },
                            child: Container(
                              height: scaler.getHeight(18),
                              width: scaler.getHeight(18),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xff6747CD),
                                        Color(0x8C3300D6)
                                      ]),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x80000000),
                                      blurRadius: 4.0, // soften the shadow
                                      spreadRadius: 0, //extend the shadow
                                      offset: Offset(
                                        0, // Move to right 10  horizontally
                                        6, // Move to bottom 10 Vertically
                                      ),
                                    )
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: scaler.getHeight(6),
                                    child: FittedBox(
                                      child: Icon(
                                        Foundation.torso_business,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                  ),
//                                SizedBox(
//                                  height: scaler.getHeight(1),
//                                ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: scaler.getHeight(4.2),
                                    child: Text(
                                      'SME',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              //height: .5,
                                              fontSize: 23,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: scaler.getHeight(1),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: scaler.getHeight(1),
                          bottom: scaler.getHeight(1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          //HSS Button
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HSSScreen()));
                            },
                            child: Container(
                              height: scaler.getHeight(18),
                              width: scaler.getHeight(18),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xff6747CD),
                                        Color(0x8C3300D6)
                                      ]),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x80000000),
                                      blurRadius: 4.0, // soften the shadow
                                      spreadRadius: 0, //extend the shadow
                                      offset: Offset(
                                        0, // Move to right 10  horizontally
                                        6, // Move to bottom 10 Vertically
                                      ),
                                    )
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: scaler.getHeight(7),
                                    child: FittedBox(
                                      child: Icon(
                                        Ionicons.ios_people,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ),
                                  ),
//                                SizedBox(
//                                  height: scaler.getHeight(1),
//                                ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: scaler.getHeight(4.2),
                                    child: Text(
                                      'HSS',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              //height: .5,
                                              fontSize: 23,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          //LHS Button
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LHSScreen()));
                            },
                            child: Container(
                              height: scaler.getHeight(18),
                              width: scaler.getHeight(18),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xff6747CD),
                                        Color(0x8C3300D6)
                                      ]),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x80000000),
                                      blurRadius: 4.0, // soften the shadow
                                      spreadRadius: 0, //extend the shadow
                                      offset: Offset(
                                        0, // Move to right 10  horizontally
                                        6, // Move to bottom 10 Vertically
                                      ),
                                    )
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: scaler.getHeight(6),
                                    child: FittedBox(
                                      child: Icon(
                                        FontAwesome5Solid.microscope,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: scaler.getHeight(1),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: scaler.getHeight(4.2),
                                    child: Text(
                                      'LHS',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              //height: .5,
                                              fontSize: 23,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
