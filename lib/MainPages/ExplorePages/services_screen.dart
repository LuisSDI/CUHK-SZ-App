import 'package:cuhkszapp/MainPages/ExplorePages/ServicesPages/sall_screen.dart';
import 'package:cuhkszapp/resources/image_slider.dart';
import 'package:cuhkszapp/resources/placeholder_page.dart';
import 'package:cuhkszapp/resources/screen_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class ServicesScreen extends StatelessWidget {
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
                    height: scaler.getHeight(5),
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "Services",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 34,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Image Carousel
            ImageSlider(
              imgList: [
                "assets/images_why_screen/why_picture_2.jpg",
                "assets/images_why_screen/why_picture_1.jpg",
                "assets/images_why_screen/why_picture_3.jpg",
                "assets/images_why_screen/why_picture_4.jpg",
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: scaler.getHeight(1), bottom: scaler.getHeight(1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ScreenButtom(
                        detail: '''CIDE'''.trim(),
                        iconData: Icons.business,
                        screen: PlaceHolderPage(),
                      ),
                      ScreenButtom(
                        detail: '''SALL 
Center'''
                            .trim(),
                        iconData: FontAwesome.language,
                        screen: SallScreen(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: scaler.getHeight(1), bottom: scaler.getHeight(1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ScreenButtom(
                        detail: '''Career Service Center'''.trim(),
                        iconData: MaterialCommunityIcons.briefcase,
                        screen: PlaceHolderPage(),
                      ),
                      ScreenButtom(
                        detail: '''Health 
Center'''
                            .trim(),
                        iconData: FontAwesome.hospital_o,
                        screen: PlaceHolderPage(),
                      ),
                    ],
                  ),
                ),
              ],
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
