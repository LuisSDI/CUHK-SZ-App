import 'package:cached_network_image/cached_network_image.dart';
import 'package:cuhkszapp/resources/expandable_tile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class EntryReqScreen extends StatelessWidget {
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
                    "Entry Requirements",
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
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: scaler.getWidth(2), vertical: scaler.getWidth(4)),
          child: Container(
            height: scaler.getHeight(30),
            width: scaler.getWidth(100),
            child: CachedNetworkImage(
              imageUrl:
                  "https://firebasestorage.googleapis.com/v0/b/cuhk-shenzhen-app.appspot.com/o/app_assets%2Fentry_requirements%2Fentry_picture_1.png?alt=media&token=586ba1c3-e20e-4451-a2f0-6360cc3bd680",
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress)),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
        // Who Expandable
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
          child: ExpansionItem(
            title: "Who can apply?",
            data:
                'Applicants must have held a passport from a country or region other than Mainland China,'
                ' Hong Kong, Macao or Taiwan for a minimum four years.',
          ),
        ),
        //What Expandable
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
          child: ExpansionItem(
            title: "What qualifications are required?",
            richText: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        '''We welcome applicants with a wide range of qualifications. You just need to take any of the following:
•  International Baccalaureate Diploma (IB)
•  General Certificate of Education (GCE / A-Level)
•  Scholastic Assessment Test (SAT) / American 
     College Test (ACT)
•  Local national higher education entrance 
     examination, please click ''',
                    style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                  TextSpan(
                    text: 'here',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                    )),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        launch(
                            'https://admissions.cuhk.edu.cn/upLoad/admissions/Admission-Requirements2020.pdf');
                      },
                  ),
                  TextSpan(
                    text: ''' for more information
•  Completed at least one year of undergraduate study 
     at a qualified university
•  Completed at least one year of study leading to the 
     qualification of associate degree / higher diploma or
     its equivalent''',
                    style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
        //What minimum Expandable
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
          child: ExpansionItem(
            title: "What is the minimum English language requirement?",
            special: Container(
              width: double.infinity,
              color: Color(0xff6747CD),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '''Applicants should have attained an acceptable level of proficiency in English. Below are the minimum required scores or grades for some of the more common international examinations.''',
                    style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                  Container(
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
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      'Examination',
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
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      'Minimum Attainment',
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
                                    child: Text(
                                      'IELTS',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.left,
                                    )),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      '6.0',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            ]),
                            //Row 3
                            TableRow(children: [
                              TableCell(
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      'TOEFL (Internet-based test)',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.left,
                                    )),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      '80',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            ]),
                            //Row 4
                            TableRow(children: [
                              TableCell(
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      'SAT Evidence-Based Reading and Writing',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.left,
                                    )),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      '590',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            ]),
                            //Row 5
                            TableRow(children: [
                              TableCell(
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      'ACT combined English / Writing or English Language Arts (ELA)',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.left,
                                    )),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      '23',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            ]),
                            //Row 6
                            TableRow(children: [
                              TableCell(
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      'GCSE',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.left,
                                    )),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      'C',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            ]),
                            //Row 7
                            TableRow(children: [
                              TableCell(
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      'GCE',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.left,
                                    )),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      'E',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            ]),
                            //Row 8
                            TableRow(children: [
                              TableCell(
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      'IB',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.left,
                                    )),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      '4',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            ]),
                            //Row 9
                            TableRow(children: [
                              TableCell(
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      'Australian State or Territory High School Certificate Grade 12 English',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.left,
                                    )),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      '80%',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            ]),
                            //Row 10
                            TableRow(children: [
                              TableCell(
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      'Canadian Grade 12 English',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.left,
                                    )),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      '70%',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            ]),
                            //Row 11
                            TableRow(children: [
                              TableCell(
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      'Indian Central or State Board Exam Grade 12 English',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.left,
                                    )),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      '80%',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            ]),
                            //Row 12
                            TableRow(children: [
                              TableCell(
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      'Malaysian SPM / UEC Senior English Language',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.left,
                                    )),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      'C / B4',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            ]),
                            //Row 13
                            TableRow(children: [
                              TableCell(
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      'Singapore GCE A-Level H1 General Paper',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                      textAlign: TextAlign.left,
                                    )),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Container(
                                    padding:
                                        EdgeInsets.all(scaler.getHeight(.5)),
                                    child: Text(
                                      'C',
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
                ],
              ),
            ),
          ),
        ),
        //How Expandable
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
          child: ExpansionItem(
            title: "How to Apply",
            data: '''To apply for CUHK-Shenzhen 2020 Undergraduate 
Programmes, students need to prepare the following 
application documents, and then submit to the 
Online Application System in our website or apply using the Apply tab inside the application.

•  Copies of passport
•  Academic transcript(s) (legalized by the school) with the average score of all subjects for each semester
•  English test score
•  Personal statement
•  Two recommendation letters

Application Deadline: JUNE 15,2020

*Notes: Where a document is not in English, it must be accompanied by a certified English translation by a sworn translator, court translator, authorized public translator, certified translator, expert translator or an official translator. The original certificates/academic transcripts will normally be required for verification upon admission.''',
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
