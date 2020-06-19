import 'package:cuhkszapp/resources/expandable_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class FeeFinanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
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
                    "Fee & Finance",
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 33,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),

        //Entrance Expandable
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
          child: ExpansionItem(
            title: "Entrance Expenses",
            special: Container(
              width: double.infinity,
              color: Color(0xff6747CD),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: scaler.getHeight(1)),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Table(
                              columnWidths: {
                                0: FractionColumnWidth(.5),
                                1: FractionColumnWidth(.5)
                              },
                              border: TableBorder.all(
                                  color: Color(0xff6747CD), width: 2),
                              children: [
                                //Row 1
                                TableRow(children: [
                                  TableCell(
                                    child: Container(
                                        padding: EdgeInsets.all(
                                            scaler.getHeight(.5)),
                                        child: Text(
                                          'Expenses',
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
                                          'Cost',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xff6747CD),
                                                  fontWeight: FontWeight.bold)),
                                          textAlign: TextAlign.center,
                                        )),
                                  ),
                                ]),
                                //Row 2
                                TableRow(children: [
                                  TableCell(
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(scaler.getHeight(.5)),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Tuition Fee',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                            ),
                                            TextSpan(
                                              text: ' (per academic year)',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black87,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(scaler.getHeight(.5)),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'RMB',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black87)),
                                            ),
                                            TextSpan(
                                              text: ' 95,000',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                                //Row 3
                                TableRow(children: [
                                  TableCell(
                                    child: Container(
                                        padding: EdgeInsets.all(
                                            scaler.getHeight(.5)),
                                        child: Text(
                                          'On-campus Housing',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          textAlign: TextAlign.left,
                                        )),
                                  ),
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(scaler.getHeight(.5)),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'RMB',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black87)),
                                            ),
                                            TextSpan(
                                              text: ' 1,200',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                                //Row 4
                                TableRow(children: [
                                  TableCell(
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(scaler.getHeight(.5)),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Textbook Fee',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                            ),
                                            TextSpan(
                                              text:
                                                  ' (this fee is based on students’ choice. if they want to have RMB 1,200 all the hard copy textbook, they need to pay for the textbook fee, however wedo provide students with electronic version textbook which is free of charge for students.)',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(scaler.getHeight(.5)),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'RMB',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black87)),
                                            ),
                                            TextSpan(
                                              text: ' 1,200',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                                //Row 5
                                TableRow(children: [
                                  TableCell(
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(scaler.getHeight(.5)),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Medical Insurance',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                            ),
                                            TextSpan(
                                              text: ' (per year)',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(scaler.getHeight(.5)),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'RMB',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black87)),
                                            ),
                                            TextSpan(
                                              text: ' 1,200',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                                //Row 6
                                TableRow(children: [
                                  TableCell(
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(scaler.getHeight(.5)),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Study Miscellaneous Fee',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                            ),
                                            TextSpan(
                                              text: ' (per year)',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(scaler.getHeight(.5)),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'RMB',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black87)),
                                            ),
                                            TextSpan(
                                              text: ' 500',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                                //Row 7
                                TableRow(children: [
                                  TableCell(
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(scaler.getHeight(.5)),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Living Cost',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                            ),
                                            TextSpan(
                                              text: ' (per month)',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(scaler.getHeight(.5)),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'RMB',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black87)),
                                            ),
                                            TextSpan(
                                              text: ' 2,000',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                                //Row 8
                                TableRow(children: [
                                  TableCell(
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(scaler.getHeight(.5)),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Meal Fee',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                            ),
                                            TextSpan(
                                              text: ' (per dish per person)',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(scaler.getHeight(.5)),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'RMB',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black87)),
                                            ),
                                            TextSpan(
                                              text: ' 10-20',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                                //Row 9
                                TableRow(children: [
                                  TableCell(
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(scaler.getHeight(.5)),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Bus Fee',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                            ),
                                            TextSpan(
                                              text: ' (per single journey)',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(scaler.getHeight(.5)),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'RMB',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black87)),
                                            ),
                                            TextSpan(
                                              text: ' 2-10',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                                //Row 10
                                TableRow(children: [
                                  TableCell(
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(scaler.getHeight(.5)),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Subway Fee',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                            ),
                                            TextSpan(
                                              text: ' (per single journey)',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(scaler.getHeight(.5)),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'RMB',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black87)),
                                            ),
                                            TextSpan(
                                              text: ' 2-10',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              ]),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: scaler.getHeight(1), bottom: scaler.getHeight(1)),
                    child: Text(
                      '''Notes:
•  All information is subject to change without prior 
     notice.
•  Estimated cost is subject to lifestyle and 
     preferences of individuals.'''
                          .trim(),
                      textAlign: TextAlign.left,
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Scholarships Text
        Padding(
          padding: EdgeInsets.only(bottom: scaler.getHeight(1)),
          child: Container(
            height: scaler.getHeight(2.5),
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                "Scholarships",
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 23,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
        //Scholarship Intro Text
        Padding(
          padding: EdgeInsets.only(
              bottom: scaler.getHeight(1), left: scaler.getHeight(1)),
          child: Text(
            '''To encourage academic excellence, The Chinese University of Hong Kong, Shenzhen offers an expanding range of scholarships to international students. The Scholarships could be categorized as following:''',
            textAlign: TextAlign.left,
            style: GoogleFonts.lato(
                textStyle: TextStyle(
              fontSize: 15,
              color: Colors.black87,
            )),
          ),
        ),
        //Entry Scholarship Expandable
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
          child: ExpansionItem(
            title: "Entry Scholarships for 4 years",
            data:
                '''If your application for CUHK-Shenzhen is successful, you will automatically be considered for an entry scholarship. There are four types of entry scholarship to cover tuition fees: 

•  Honor Scholarship (120,000 RMB / yr.), 
•  Full Tuition + Accommodation Scholarship 
     (96,200 RMB / yr.), 
•  Half Tuition  + Accommodation Scholarship 
     (48,700 RMB / yr.),
•  Quarter Tuition + Accommodation Scholarship 
     (24,950 RMB / yr.), or
•  Full-accommodation Fee Scholarship 
     (1,200 RMB / yr.)

Selection will be based on your suitability for CUHK-Shenzhen, taking into account your academic performance, English ability and character as assessed through an interview. The scholarship will be provided for 4 years, as long as your GPA remains above 3.0.''',
          ),
        ),
        //Entry Scholarship Expandable
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
          child: ExpansionItem(
            title: "Academic Performance Scholarship",
            data:
                '''In addition to the Entry Scholarship, students with outstanding academic performance may receive one of three Academic Performance Scholarships:

•  Tier 1 (80,000 RMB / yr.)
•  Tier 2 (40,000 RMB / yr.)
•  Tier 3 (20,000 RMB / yr.)''',
          ),
        ),
        // Government Text
        Padding(
          padding: EdgeInsets.only(bottom: scaler.getHeight(1)),
          child: Container(
            height: scaler.getHeight(5.5),
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                'Government-Sponsored \n'
                'International Scholarship',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 23,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
        //Universidade Expandable
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
          child: ExpansionItem(
            title: "Shenzhen Universiade International Scholarship",
            richText: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        '''This foundation was established by the Shenzhen government following the university games held in Shenzhen to promote sporting spirit whilst boosting cultural and educational exchange of international youth. 
The foundation supports full-time international students at the bachelor level or above in Shenzhen. The scholarship ranges from 20,000 RMB to 40,000 RMB. Applications open in April each year.''',
                    style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
        //China in ... Expandable
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
          child: ExpansionItem(
            title:
                "Guangdong Government Outstanding International Student Scholarship",
            data:
                '''These scholarships have been created by the provincial government to support international students studying in Guangdong to encourage talent cultivation, scientific research, social service and cultural exchange. They are awarded to full-time university students at the bachelor level or above on the basis of academic performance. The value of the scholarship is 10,000 RMB. Applications open in October each year.''',
          ),
        ),
      ])),
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
