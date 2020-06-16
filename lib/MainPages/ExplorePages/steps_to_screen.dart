import 'package:cuhkszapp/resources/step_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_slider/page_slider.dart';

class StepsToScreen extends StatefulWidget {
  @override
  _StepsToScreenState createState() => _StepsToScreenState();
}

class _StepsToScreenState extends State<StepsToScreen> {
  int currentIndex = 1;

  List<StepContent> steps = [
    StepContent(
      iconData: AntDesign.heart,
      text: '''Study hard 
to get good scores'''
          .trim(),
      key: UniqueKey(),
    ),
    StepContent(
      iconData: AntDesign.calendar,
      text: '''Think carefully about what 
makes you happy and where 
you want your life to go'''
          .trim(),
      key: UniqueKey(),
    ),
    StepContent(
      iconData: MaterialCommunityIcons.book_open_page_variant,
      text: '''Choose a major
you love
'''
          .trim(),
      key: UniqueKey(),
    ),
    StepContent(
      iconData: Ionicons.ios_paper,
      text: '''Meet the application
deadline and entry 
requirements
'''
          .trim(),
      key: UniqueKey(),
    ),
    StepContent(
      iconData: AntDesign.pdffile1,
      text: '''Collect all 
necessary documents
'''
          .trim(),
      key: UniqueKey(),
    ),
    StepContent(
      iconData: Feather.clock,
      text: '''Complete your 
online application
'''
          .trim(),
      key: UniqueKey(),
    ),
    StepContent(
      iconData: Icons.computer,
      text: '''Cross your fingers
'''
          .trim(),
      key: UniqueKey(),
    ),
    StepContent(
      iconData: Entypo.emoji_happy,
      text: '''If you are lucky, 
join a scholarship interview
'''
          .trim(),
      key: UniqueKey(),
    ),
    StepContent(
      iconData: Entypo.newsletter,
      text: '''Receive your 
conditional offer
'''
          .trim(),
      key: UniqueKey(),
    ),
    StepContent(
      iconData: FontAwesome.cny,
      text: '''Reserve your place and 
scholarship by paying 
the advanced tuition fee
'''
          .trim(),
      key: UniqueKey(),
    ),
    StepContent(
      iconData: Entypo.folder,
      text: '''Submit your final scores 
when available to receive
an unconditional offer
'''
          .trim(),
      key: UniqueKey(),
    ),
    StepContent(
      iconData: FontAwesome5Solid.passport,
      text: '''Apply for visa 
to study in China
'''
          .trim(),
      key: UniqueKey(),
    ),
    StepContent(
      iconData: FontAwesome.pencil_square_o,
      text: '''Book flights to
Shenzhen, China
'''
          .trim(),
      key: UniqueKey(),
    ),
    StepContent(
      iconData: Icons.business_center,
      text: '''Pack for an exciting 
university life 
'''
          .trim(),
      key: UniqueKey(),
    ),
    StepContent(
      iconData: Icons.flight_takeoff,
      text: '''Wave goodbye 
to your old life
'''
          .trim(),
      key: UniqueKey(),
    ),
    StepContent(
      iconData: FontAwesome5.handshake,
      text: '''Welcome to the 
Chinese University of 
Hong Kong, Shenzhen 
'''
          .trim(),
      key: UniqueKey(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);

    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                        "Steps to CUHK",
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
            //Steps Progress Bar
            Padding(
              padding: EdgeInsets.only(
                  top: scaler.getWidth(2), bottom: scaler.getWidth(2)),
              child: Center(
                child: Stack(alignment: Alignment.center, children: [
                  Container(
                    color: Color(0xff6747CD),
                    height: scaler.getHeight(.5),
                    width: scaler.getWidth(100),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 600),
                        alignment: Alignment.center,
                        child: Text(
                          (currentIndex == 1)
                              ? "1"
                              : (currentIndex == 16)
                                  ? "14"
                                  : (currentIndex - 1).toString(),
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        height: (currentIndex == 1)
                            ? scaler.getWidth(12)
                            : scaler.getWidth(10),
                        width: (currentIndex == 1)
                            ? scaler.getWidth(12)
                            : scaler.getWidth(10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xff6747CD)),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 600),
                        alignment: Alignment.center,
                        child: Text(
                          (currentIndex == 1)
                              ? "2"
                              : (currentIndex == 16)
                                  ? "15"
                                  : (currentIndex).toString(),
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        height: (currentIndex > 1 && currentIndex < 16)
                            ? scaler.getWidth(12)
                            : scaler.getWidth(10),
                        width: (currentIndex > 1 && currentIndex < 16)
                            ? scaler.getWidth(12)
                            : scaler.getWidth(10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xff6747CD)),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 600),
                        alignment: Alignment.center,
                        child: Text(
                          (currentIndex == 1)
                              ? "3"
                              : (currentIndex == 16)
                                  ? "16"
                                  : (currentIndex + 1).toString(),
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        height: (currentIndex == 16)
                            ? scaler.getWidth(12)
                            : scaler.getWidth(10),
                        width: (currentIndex == 16)
                            ? scaler.getWidth(12)
                            : scaler.getWidth(10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xff6747CD)),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
            AnimatedSwitcher(
              child: steps[currentIndex - 1],
              duration: Duration(milliseconds: 600),
            ),
            Padding(
              padding: EdgeInsets.only(top: scaler.getWidth(2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (currentIndex == 1) {
                        } else {
                          currentIndex--;
                        }
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: Icon(
                            AntDesign.arrowleft,
                            color: Colors.white,
                            size: 35,
                          )),
                      width: scaler.getWidth(15),
                      height: scaler.getWidth(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xff5534C1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 4.0,
                            // soften the shadow//extend the shadow
                            offset: Offset(
                              0,
                              6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (currentIndex == 16) {
                        } else {
                          currentIndex++;
                        }
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: Icon(
                            AntDesign.arrowright,
                            color: Colors.white,
                            size: 35,
                          )),
                      width: scaler.getWidth(15),
                      height: scaler.getWidth(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xff5534C1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 4.0,
                            // soften the shadow//extend the shadow
                            offset: Offset(
                              0,
                              6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
