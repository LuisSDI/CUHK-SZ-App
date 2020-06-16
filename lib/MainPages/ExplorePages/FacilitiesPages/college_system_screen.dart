import 'package:cuhkszapp/resources/image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class CollegeSysScreen extends StatelessWidget {
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
                        "College System",
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
                height: scaler.getHeight(43),
                alignment: Alignment.topLeft,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    '''Based on the British traditions of Oxford and 
Cambridge, CUHK Shenzhen offers a unique 
college system – an environment graduates 
identify amongst their fondest memories. The 
colleges are congenial communities, where every 
room offers a chance to meet fellow residents,
make new friends and grow together. All 
undergraduate students live in college 
accommodation. Most international students 
receive a scholarship for free accommodation.

At CUHK-Shenzhen, there are four Colleges: Shaw, 
Diligentia, Muse and Harmonia. Each has their own 
facilities (eg gym, shared kitchen, laundry,
self-study rooms, TV rooms, meditation rooms, 
dance studios and music rooms) and distinct 
character which will quickly become your home
away from home. Allocation to colleges is done 
randomly before you arrive at university.'''
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
