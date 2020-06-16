import 'package:cuhkszapp/MainPages/ExplorePages/entry_req_screen.dart';
import 'package:cuhkszapp/MainPages/ExplorePages/facilities_screen.dart';
import 'package:cuhkszapp/MainPages/ExplorePages/faq_screen.dart';
import 'package:cuhkszapp/MainPages/ExplorePages/fee_finance_screen.dart';
import 'package:cuhkszapp/MainPages/ExplorePages/services_screen.dart';
import 'package:cuhkszapp/MainPages/ExplorePages/why_screen.dart';
import 'package:cuhkszapp/resources/screen_buttom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ExplorePages/steps_to_screen.dart';

class ExploreTab extends StatelessWidget {
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
                        "Discover,",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 36,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
                //CUHK SZ Text
                Container(
                  height: scaler.getHeight(3),
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "CUHK Shenzhen",
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
                    Padding(
                      padding: EdgeInsets.only(
                          top: scaler.getHeight(1),
                          bottom: scaler.getHeight(1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ScreenButtom(
                            detail: 'Why?',
                            iconData: AntDesign.questioncircleo,
                            screen: WhyScreen(),
                          ),
                          SizedBox(
                            width: scaler.getHeight(2),
                          ),
                          ScreenButtom(
                            detail: '''Entry
Requirements'''
                                .trim(),
                            iconData: Ionicons.ios_list_box,
                            screen: EntryReqScreen(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: scaler.getHeight(1),
                          bottom: scaler.getHeight(1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ScreenButtom(
                            detail: '''Fees &
Finance'''
                                .trim(),
                            iconData: Icons.monetization_on,
                            screen: FeeFinanceScreen(),
                          ),
                          SizedBox(
                            width: scaler.getHeight(2),
                          ),
                          ScreenButtom(
                            detail: 'Facilities',
                            iconData: FontAwesome5.building,
                            screen: FacilitiesScreen(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: scaler.getHeight(1),
                          bottom: scaler.getHeight(1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ScreenButtom(
                            detail: 'Services',
                            iconData: Icons.local_mall,
                            screen: ServicesScreen(),
                          ),
                          SizedBox(
                            width: scaler.getHeight(2),
                          ),
                          ScreenButtom(
                            detail: 'FAQs',
                            iconData: Icons.question_answer,
                            screen: FaqScreen(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: scaler.getHeight(1),
                          bottom: scaler.getHeight(1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ScreenButtom(
                            detail: '''Steps to
CUHK'''
                                .trim(),
                            iconData: Ionicons.md_walk,
                            screen: StepsToScreen(),
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
