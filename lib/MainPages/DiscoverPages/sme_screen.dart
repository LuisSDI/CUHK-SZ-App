import 'package:cuhkszapp/resources/major_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class SMEScreen extends StatelessWidget {
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
                        '''School of Management
and Economics''',
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
            //ECO Button
            Padding(
              padding: EdgeInsets.only(
                  top: scaler.getHeight(1),
                  bottom: scaler.getHeight(1),
                  left: scaler.getHeight(1.5),
                  right: scaler.getHeight(1.5)),
              child: MajorButtom(
                detail: '''Economics'''.trim(),
                image: "assets/images_sme_majors/ECO.jpg",
              ),
            ),
            //MAR Button
            Padding(
              padding: EdgeInsets.only(
                  top: scaler.getHeight(1),
                  bottom: scaler.getHeight(1),
                  left: scaler.getHeight(1.5),
                  right: scaler.getHeight(1.5)),
              child: MajorButtom(
                detail: '''Marketing'''.trim(),
                image: "assets/images_sme_majors/MAR.jpg",
              ),
            ),
            //FIN Button
            Padding(
              padding: EdgeInsets.only(
                  top: scaler.getHeight(1),
                  bottom: scaler.getHeight(1),
                  left: scaler.getHeight(1.5),
                  right: scaler.getHeight(1.5)),
              child: MajorButtom(
                detail: '''Finance'''.trim(),
                image: "assets/images_sme_majors/FIN.jpg",
              ),
            ),
            //BUS Button
            Padding(
              padding: EdgeInsets.only(
                  top: scaler.getHeight(1),
                  bottom: scaler.getHeight(1),
                  left: scaler.getHeight(1.5),
                  right: scaler.getHeight(1.5)),
              child: MajorButtom(
                detail: '''Global 
Business 
Studies'''
                    .trim(),
                image: "assets/images_sme_majors/BUS.jpg",
                alignment: Alignment(-.8, 0),
              ),
            ),

            //ACO Button
            Padding(
              padding: EdgeInsets.only(
                  top: scaler.getHeight(1),
                  bottom: scaler.getHeight(1),
                  left: scaler.getHeight(1.5),
                  right: scaler.getHeight(1.5)),
              child: MajorButtom(
                detail: '''Professional 
Accounting'''
                    .trim(),
                image: "assets/images_sme_majors/MAR.jpg",
              ),
            ),
            //FIN ENG Button
            Padding(
              padding: EdgeInsets.only(
                  top: scaler.getHeight(1),
                  bottom: scaler.getHeight(1),
                  left: scaler.getHeight(1.5),
                  right: scaler.getHeight(1.5)),
              child: MajorButtom(
                detail: '''Financial 
Engineering'''
                    .trim(),
                image: "assets/images_sme_majors/ECO.jpg",
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
