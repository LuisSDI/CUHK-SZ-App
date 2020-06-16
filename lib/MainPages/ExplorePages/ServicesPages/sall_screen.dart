import 'package:cuhkszapp/resources/image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class SallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: scaler.getHeight(3), bottom: scaler.getHeight(1.5)),
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
                        "SALL Center",
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
            //Intro Text
            Padding(
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: Container(
                height: scaler.getHeight(35),
                alignment: Alignment.topLeft,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    '''Effective language use, whether it be English or 
Chinese, is the key to understanding and being 
understood. Studying at CUHK Shenzhen will pose 
a number of linguistic challenges, but the
Self-Access Language Learning (SALL) Centre is 
available to help you overcome language 
difficulties. The language of academic study 
intimidates native speakers. For students learning 
English, this challenge is even more intimidating. 
Simultaneously, Chinese is widely considered one 
of the most difficult languages to learn. Therefore, 
to support your English and Chinese tuition, the 
SALL Centre offers additional programs and 
activities, allowing you to learn in a way that suits 
your specific learning style.'''
                        .trim(),
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 15, color: Color(0xff5A5A5B), height: 1)),
                  ),
                ),
              ),
            ),
            SizedBox()
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
