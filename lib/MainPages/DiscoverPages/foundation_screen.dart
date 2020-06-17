
import 'package:cuhkszapp/resources/foundation_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class FoundationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //Title Text
            Padding(
              padding: EdgeInsets.only(top: scaler.getHeight(3)),
              child: Row(
                children: <Widget>[
                  //Buttom for back
                  Container(
                    child: IconButton(
                      icon: Icon(
                        Ionicons.ios_arrow_back,
                        color: Color(0xff6747CD),
                        size: 30,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  //Title Text
                  Container(
                    height: scaler.getHeight(7),
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        '''Foundation Courses''',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Foundation Graph
            Padding(
              padding: EdgeInsets.only(left: scaler.getHeight(1),
              right: scaler.getHeight(1),
              bottom: scaler.getHeight(1)),
              child: Container(
                height: scaler.getHeight(57),
                  child: FoundationGraph()),
            ),
            //Detail Text
            Padding(
              padding: EdgeInsets.only(bottom: scaler.getHeight(1),
              right: scaler.getHeight(1),
              left: scaler.getHeight(1)),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "* Some programs require more General Education or free electives",
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 14,
                          color: Color(0xff6747CD),
                  )),
                ),
              ),
            ),
            //General Education Title
            Padding(
              padding: EdgeInsets.only(bottom: scaler.getHeight(1),
              left: scaler.getHeight(1)),
              child: Container(
                height: scaler.getHeight(2.5),
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "General Education",
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            //General Education Info
            Padding(
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2),),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  '''General Education (GE) The foundation of education at CUHK, General Education (GE) is an award winning course. These intriguing courses will instill you with an awareness of critical powers and cultural sensitivity, qualities that define an educated world citizen of today and tomorrow. Combining Chinese humanistic ideals and western liberal arts to explore cultural heritage, you’ll learn to take a critical perspective on humanity, nature and perennial issues. GE connects your intellectual pursuits at study, at home and in the community in order to help you become a lifelong learner with global awareness.'''
                      .trim(),
                  textAlign: TextAlign.left,
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 15, color: Color(0xff5A5A5B), height: 1)),
                ),
              ),
            ),
            SizedBox(
              height: scaler.getHeight(1),
            )


          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: scaler.getHeight(10),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff6747CD), Color(0x8C3300D6)])),
      ),
    );
  }
}
