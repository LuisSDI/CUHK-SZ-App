import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

import 'expandable_tile.dart';
import 'image_slider.dart';

class MajorScreen extends StatelessWidget {
  final String title;
  final String intro;
  final Map schoolPackage;
  Map majorReq;
  Map majorElec;
  final List<String> pictures;
  String detail;
  final Container specialElec;
  final Container specialReq;
  final String studentPicture;
  final String studentName;
  final String studentCountry;
  final String studentOpinion;

  MajorScreen(
      {Key key,
      this.title,
      this.intro,
      this.specialReq,
      @required this.schoolPackage,
      this.majorReq,
      this.majorElec,
      this.detail,
      this.pictures,
      this.specialElec,
      this.studentPicture,
      this.studentName,
      this.studentCountry,
      this.studentOpinion})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    detail ??= "";
    majorReq ??= {};
    majorElec ??= {};
    List schoolkeys = [];
    List schoolval = [];
    schoolPackage.forEach((key, value) {
      schoolkeys.add(key);
      schoolval.add(value);
    });
    List majorkeys = [];
    List majorval = [];
    majorReq.forEach((key, value) {
      majorkeys.add(key);
      majorval.add(value);
    });
    List eleckeys = [];
    List elecval = [];
    majorElec.forEach((key, value) {
      eleckeys.add(key);
      elecval.add(value);
    });
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
                        title,
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
            ImageSlider(
              imgList: pictures,
            ),
            //Intro Text
            Padding(
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: Container(
                alignment: Alignment.topLeft,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    intro.trim(),
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 15, color: Color(0xff5A5A5B), height: 1)),
                  ),
                ),
              ),
            ),
            // Course List Text
            Padding(
              padding: EdgeInsets.only(top: scaler.getHeight(1)),
              child: Container(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Course List",
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            //School Expandable
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                  horizontal: scaler.getWidth(2),
                  vertical: scaler.getHeight(1)),
              child: ExpansionItem(
                title:
                    "School Package for the School of Science and Engineering",
                special: Container(
                  width: double.infinity,
                  color: Color(0xff6747CD),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(scaler.getHeight(1)),
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              //Row 1
                              Table(
                                columnWidths: {
                                  0: FractionColumnWidth(.5),
                                  1: FractionColumnWidth(.5)
                                },
                                border: TableBorder.all(
                                    color: Color(0xff6747CD), width: 2),
                                children: [
                                  TableRow(children: [
                                    TableCell(
                                      child: Container(
                                          padding: EdgeInsets.all(
                                              scaler.getHeight(.5)),
                                          child: Text(
                                            'Course Code',
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff6747CD))),
                                            textAlign: TextAlign.center,
                                          )),
                                    ),
                                    TableCell(
                                      child: Container(
                                          padding: EdgeInsets.all(
                                              scaler.getHeight(.5)),
                                          child: Text(
                                            'Course Title',
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xff6747CD),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            textAlign: TextAlign.center,
                                          )),
                                    ),
                                  ]),
                                  //Row 2
                                  for (var i = 0; i < schoolkeys.length; i++)
                                    TableRow(children: [
                                      TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Container(
                                            padding: EdgeInsets.all(
                                                scaler.getHeight(.5)),
                                            child: Text(
                                              schoolkeys[i],
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                fontSize: 14,
                                              )),
                                              textAlign: TextAlign.center,
                                            )),
                                      ),
                                      TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Container(
                                            padding: EdgeInsets.all(
                                                scaler.getHeight(.5)),
                                            child: Text(
                                              schoolval[i],
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                fontSize: 14,
                                              )),
                                              textAlign: TextAlign.center,
                                            )),
                                      ),
                                    ]),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: scaler.getHeight(1),
                            bottom: scaler.getHeight(1),
                            right: scaler.getHeight(1)),
                        child: Text(
                          detail,
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //Major Expandable
            (majorReq.isEmpty)
                ? specialReq
                : Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(
                        left: scaler.getWidth(2),
                        right: scaler.getWidth(2),
                        bottom: scaler.getHeight(1)),
                    child: ExpansionItem(
                      title: "Major Required Courses",
                      special: Container(
                        width: double.infinity,
                        color: Color(0xff6747CD),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(scaler.getHeight(1)),
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    //Row 1
                                    Table(
                                      columnWidths: {
                                        0: FractionColumnWidth(.5),
                                        1: FractionColumnWidth(.5)
                                      },
                                      border: TableBorder.all(
                                          color: Color(0xff6747CD), width: 2),
                                      children: [
                                        TableRow(children: [
                                          TableCell(
                                            child: Container(
                                                padding: EdgeInsets.all(
                                                    scaler.getHeight(.5)),
                                                child: Text(
                                                  'Course Code',
                                                  style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0xff6747CD))),
                                                  textAlign: TextAlign.center,
                                                )),
                                          ),
                                          TableCell(
                                            child: Container(
                                                padding: EdgeInsets.all(
                                                    scaler.getHeight(.5)),
                                                child: Text(
                                                  'Course Title',
                                                  style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xff6747CD),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  textAlign: TextAlign.center,
                                                )),
                                          ),
                                        ]),
                                        //Row 2
                                        for (var i = 0;
                                            i < majorkeys.length;
                                            i++)
                                          TableRow(children: [
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Container(
                                                  padding: EdgeInsets.all(
                                                      scaler.getHeight(.5)),
                                                  child: Text(
                                                    majorkeys[i],
                                                    style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                      fontSize: 14,
                                                    )),
                                                    textAlign: TextAlign.center,
                                                  )),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Container(
                                                  padding: EdgeInsets.all(
                                                      scaler.getHeight(.5)),
                                                  child: Text(
                                                    majorval[i],
                                                    style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                      fontSize: 14,
                                                    )),
                                                    textAlign: TextAlign.center,
                                                  )),
                                            ),
                                          ]),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            //Elective Expandable
            (majorElec.isEmpty)
                ? specialElec
                : Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(
                      left: scaler.getWidth(2),
                      right: scaler.getWidth(2),
                    ),
                    child: ExpansionItem(
                      title: "Major Elective Courses",
                      special: Container(
                        width: double.infinity,
                        color: Color(0xff6747CD),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(scaler.getHeight(1)),
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    //Row 1
                                    Table(
                                      columnWidths: {
                                        0: FractionColumnWidth(.5),
                                        1: FractionColumnWidth(.5)
                                      },
                                      border: TableBorder.all(
                                          color: Color(0xff6747CD), width: 2),
                                      children: [
                                        TableRow(children: [
                                          TableCell(
                                            child: Container(
                                                padding: EdgeInsets.all(
                                                    scaler.getHeight(.5)),
                                                child: Text(
                                                  'Course Code',
                                                  style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0xff6747CD))),
                                                  textAlign: TextAlign.center,
                                                )),
                                          ),
                                          TableCell(
                                            child: Container(
                                                padding: EdgeInsets.all(
                                                    scaler.getHeight(.5)),
                                                child: Text(
                                                  'Course Title',
                                                  style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xff6747CD),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  textAlign: TextAlign.center,
                                                )),
                                          ),
                                        ]),
                                        //Row 2
                                        for (var i = 0;
                                            i < eleckeys.length;
                                            i++)
                                          TableRow(children: [
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Container(
                                                  padding: EdgeInsets.all(
                                                      scaler.getHeight(.5)),
                                                  child: Text(
                                                    eleckeys[i],
                                                    style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                      fontSize: 14,
                                                    )),
                                                    textAlign: TextAlign.center,
                                                  )),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Container(
                                                  padding: EdgeInsets.all(
                                                      scaler.getHeight(.5)),
                                                  child: Text(
                                                    elecval[i],
                                                    style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                      fontSize: 14,
                                                    )),
                                                    textAlign: TextAlign.center,
                                                  )),
                                            ),
                                          ]),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            // Student's Opinion Text
            Padding(
              padding: EdgeInsets.only(bottom: scaler.getHeight(1)),
              child: Container(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Student's Opinion",
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: scaler.getHeight(1)),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: scaler.getHeight(1), right: scaler.getHeight(1)),
                    child: Container(
                      child: CircleAvatar(
                        radius: scaler.getHeight(7),
                        backgroundImage: AssetImage(
                          studentPicture,
                        ),
                        foregroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                studentName,
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
//                        Container(
//                          alignment: Alignment.center,
//                          child: FittedBox(
//                            fit: BoxFit.contain,
//                            child: Text(
//                              'Country: $studentCountry',
//                              style: GoogleFonts.lato(
//                                  textStyle: TextStyle(
//                                      fontSize: 15,
//                                      color: Colors.black,
//                                      fontWeight: FontWeight.bold)),
//                            ),
//                          ),
//                        ),
                          Container(
                            alignment: Alignment.center,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                studentOpinion,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff5A5A5B),
                                        height: 1)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
