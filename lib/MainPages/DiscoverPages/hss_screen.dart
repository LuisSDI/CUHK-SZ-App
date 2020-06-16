import 'package:cuhkszapp/resources/major_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class HSSScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                    height: scaler.getHeight(11),
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        '''School of Humanities 
and Social Science''',
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
            //Translation Button
            Padding(
              padding: EdgeInsets.only(
                  top: scaler.getHeight(1),
                  bottom: scaler.getHeight(1),
                  left: scaler.getHeight(1.5),
                  right: scaler.getHeight(1.5)),
              child: MajorButtom(
                detail: '''Translation'''.trim(),
                image: "assets/images_sse_majors/CSE.png",
                alignment: Alignment(-.3, 0),
              ),
            ),
            //PSI Button
            Padding(
              padding: EdgeInsets.only(
                  top: scaler.getHeight(1),
                  bottom: scaler.getHeight(1),
                  left: scaler.getHeight(1.5),
                  right: scaler.getHeight(1.5)),
              child: MajorButtom(
                detail: '''Applied 
Psychology'''
                    .trim(),
                image: "assets/images_sse_majors/EIE.png",
              ),
            ),
            //ENG Button
            Padding(
              padding: EdgeInsets.only(
                  top: scaler.getHeight(1),
                  bottom: scaler.getHeight(1),
                  left: scaler.getHeight(1.5),
                  right: scaler.getHeight(1.5)),
              child: MajorButtom(
                detail: '''English 
Studies'''
                    .trim(),
                image: "assets/images_sse_majors/NES.png",
                alignment: Alignment(.8, 0),
              ),
            ),
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
