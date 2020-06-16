import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class FoundationGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Container(
      child: Column(
        children: [
          //Row 1
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff6747CD), Color(0x8C3300D6)]),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        child: Text(
                      'Course',
                      style: GoogleFonts.lato(
                          textStyle:
                              TextStyle(fontSize: 12, color: Colors.white)),
                      textAlign: TextAlign.center,
                    )),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        child: Text(
                      'Subject',
                      style: GoogleFonts.lato(
                          textStyle:
                              TextStyle(fontSize: 12, color: Colors.white)),
                      textAlign: TextAlign.center,
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        child: Text(
                      'Schedule',
                      style: GoogleFonts.lato(
                          textStyle:
                              TextStyle(fontSize: 12, color: Colors.white)),
                      textAlign: TextAlign.center,
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        child: Text(
                      'Credits',
                      style: GoogleFonts.lato(
                          textStyle:
                              TextStyle(fontSize: 12, color: Colors.white)),
                      textAlign: TextAlign.center,
                    )),
                  ),
                ],
              ),
            ),
          ),
          //Row 2
          Expanded(
            flex: 10,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xffc7c7c7), width: 2)),
                                  child: Text(
                                    'Language',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border.symmetric(
                                          vertical: BorderSide(
                                              color: Color(0xffc7c7c7),
                                              width: 2),
                                        )),
                                        child: Text(
                                          'Chinese',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black)),
                                          textAlign: TextAlign.center,
                                        )),
                                  ),
                                  Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xffc7c7c7),
                                              width: 2),
                                        )),
                                        child: Text(
                                          'English',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black)),
                                          textAlign: TextAlign.center,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border(
                                          top: BorderSide(
                                              color: Color(0xffc7c7c7),
                                              width: 2),
                                          bottom: BorderSide(
                                              color: Color(0xffc7c7c7),
                                              width: 2),
                                          left: BorderSide(
                                              color: Color(0xffc7c7c7),
                                              width: 2),
                                        )),
                                        child: Text(
                                          'Year 1',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black)),
                                          textAlign: TextAlign.center,
                                        )),
                                  ),
                                  Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xffc7c7c7),
                                              width: 2),
                                          left: BorderSide(
                                              color: Color(0xffc7c7c7),
                                              width: 2),
                                        )),
                                        child: Text(
                                          'Year 1-2',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black)),
                                          textAlign: TextAlign.center,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(
                                        color: Color(0xffc7c7c7), width: 2),
                                    left: BorderSide(
                                        color: Color(0xffc7c7c7), width: 2),
                                  )),
                                  child: Text(
                                    ' IT',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(
                                        color: Color(0xffc7c7c7), width: 2),
                                    left: BorderSide(
                                        color: Color(0xffc7c7c7), width: 2),
                                  )),
                                  child: Text(
                                    'Year 1',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(
                                        color: Color(0xffc7c7c7), width: 2),
                                    left: BorderSide(
                                        color: Color(0xffc7c7c7), width: 2),
                                  )),
                                  child: Text(
                                    ' PE and Health',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(
                                        color: Color(0xffc7c7c7), width: 2),
                                    left: BorderSide(
                                        color: Color(0xffc7c7c7), width: 2),
                                  )),
                                  child: Text(
                                    'Year 1',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border(
                                    left: BorderSide(
                                        color: Color(0xffc7c7c7), width: 2),
                                    bottom: BorderSide(
                                        color: Color(0xffc7c7c7), width: 2),
                                    right: BorderSide(
                                        color: Color(0xffc7c7c7), width: 2),
                                  )),
                                  child: Text(
                                    'General Education',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xffc7c7c7),
                                              width: 2),
                                        )),
                                        child: Text(
                                          'In Dialogue with Humanity',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black)),
                                          textAlign: TextAlign.center,
                                        )),
                                  ),
                                  Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xffc7c7c7),
                                              width: 2),
                                        )),
                                        child: Text(
                                          'In Dialogue with Nature',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black)),
                                          textAlign: TextAlign.center,
                                        )),
                                  ),
                                  Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xffc7c7c7),
                                              width: 2),
                                        )),
                                        child: Text(
                                          'Chinese Cultural Heritage',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black)),
                                          textAlign: TextAlign.center,
                                        )),
                                  ),
                                  Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xffc7c7c7),
                                              width: 2),
                                        )),
                                        child: Text(
                                          'Nature, Science & Technology',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black)),
                                          textAlign: TextAlign.center,
                                        )),
                                  ),
                                  Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xffc7c7c7),
                                              width: 2),
                                        )),
                                        child: Text(
                                          'Society and Culture',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black)),
                                          textAlign: TextAlign.center,
                                        )),
                                  ),
                                  Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xffc7c7c7),
                                              width: 2),
                                        )),
                                        child: Text(
                                          'Self & Culture',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black)),
                                          textAlign: TextAlign.center,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xffc7c7c7),
                                              width: 2),
                                          left: BorderSide(
                                              color: Color(0xffc7c7c7),
                                              width: 2),
                                        )),
                                        child: Text(
                                          'Year 1',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black)),
                                          textAlign: TextAlign.center,
                                        )),
                                  ),
                                  Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xffc7c7c7),
                                              width: 2),
                                          left: BorderSide(
                                              color: Color(0xffc7c7c7),
                                              width: 2),
                                        )),
                                        child: Text(
                                          'Year 1-2',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black)),
                                          textAlign: TextAlign.center,
                                        )),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xffc7c7c7),
                                              width: 2),
                                          left: BorderSide(
                                              color: Color(0xffc7c7c7),
                                              width: 2),
                                        )),
                                        child: Text(
                                          'Year 2+  One from each area',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black)),
                                          textAlign: TextAlign.center,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xffc7c7c7), width: 2)),
                      child: Text(
                        '36',
                        style: GoogleFonts.lato(
                            textStyle:
                                TextStyle(fontSize: 12, color: Colors.black)),
                        textAlign: TextAlign.center,
                      )),
                ),
              ],
            ),
          ),
          //Row 3
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: Color(0xffc7c7c7), width: 2),
                        left: BorderSide(color: Color(0xffc7c7c7), width: 2),
                      )),
                      child: Text(
                        'Major Requirement',
                        style: GoogleFonts.lato(
                            textStyle:
                                TextStyle(fontSize: 12, color: Colors.black)),
                        textAlign: TextAlign.center,
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: Color(0xffc7c7c7), width: 2),
                        left: BorderSide(color: Color(0xffc7c7c7), width: 2),
                        right: BorderSide(color: Color(0xffc7c7c7), width: 2),
                      )),
                      child: Text(
                        '54-72*',
                        style: GoogleFonts.lato(
                            textStyle:
                                TextStyle(fontSize: 12, color: Colors.black)),
                        textAlign: TextAlign.center,
                      )),
                ),
              ],
            ),
          ),
          //Row 4
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: Color(0xffc7c7c7), width: 2),
                        left: BorderSide(color: Color(0xffc7c7c7), width: 2),
                      )),
                      child: Text(
                        'Free Electives',
                        style: GoogleFonts.lato(
                            textStyle:
                                TextStyle(fontSize: 12, color: Colors.black)),
                        textAlign: TextAlign.center,
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: Color(0xffc7c7c7), width: 2),
                        left: BorderSide(color: Color(0xffc7c7c7), width: 2),
                        right: BorderSide(color: Color(0xffc7c7c7), width: 2),
                      )),
                      child: Text(
                        '12-30*',
                        style: GoogleFonts.lato(
                            textStyle:
                                TextStyle(fontSize: 12, color: Colors.black)),
                        textAlign: TextAlign.center,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
