import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:cuhkszapp/MainPages/ApplyPages/language_qualifications_page.dart';
import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';
import 'package:cuhkszapp/resources/arrow_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class EducationHistoryPage extends StatefulWidget {
  UserBloc userBloc;
  final String userId;

  EducationHistoryPage({Key key, this.userId}) : super(key: key);


  @override
  _EducationHistoryPageState createState() => _EducationHistoryPageState();
}

class _EducationHistoryPageState extends State<EducationHistoryPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> _scaffkey = GlobalKey();
  String awardingInstitution;
  String countryInstitution;
  DateTime attendenceTo;
  DateTime attendenceFrom;
  String gradesRecord;
  String nationalExam;
  String dropdownStudy;

  Stream<DocumentSnapshot> _stream;

  @override
  void initState() {
    // Only create the stream once
    _stream = UserBloc().getEducationHistory(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: UserBloc(),
      child: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active){
              if(snapshot.hasData){
                Map educationHistory = snapshot.data.data;
                if(educationHistory != null) {
                  awardingInstitution = educationHistory['awarding institution'];
                  countryInstitution ??= educationHistory['country of qualification'];
                  nationalExam = educationHistory['national exam'];
                  dropdownStudy ??= educationHistory['study mode'];
                  gradesRecord = educationHistory['grades record'];
                  attendenceFrom ??= DateTime.parse(educationHistory['date of attendence (From)']);
                  attendenceTo ??= DateTime.parse(educationHistory['date of attendence (To)']);
                }
              }
              ScreenScaler scaler = ScreenScaler()..init(context);
              dropdownStudy ??= 'Full-Time';
              attendenceTo ??= DateTime.now();
              attendenceFrom ??= DateTime.now();
              countryInstitution ??= 'China';
              Country countryI = CountryPickerUtils.getCountryByName(countryInstitution);
              return Scaffold(
                  key: _scaffkey,
                  body: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    left: scaler.getWidth(3), top: scaler.getWidth(7)),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
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
                                              "4. Education History",
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 31,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    //Row 1 National Exam
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //National Exam Text
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: RichText(
                                              text: TextSpan(
                                                  text: "Please specify which national exam you plan to take / have taken?.",
                                                  style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                      color: Colors.black),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: "*",
                                                      style: GoogleFonts.lato(
                                                          textStyle: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color:
                                                              Color(0xff6747CD))),
                                                    )
                                                  ])),
                                        ),
                                        // Note Text
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(1),
                                              right: scaler.getHeight(.5),
                                              left: scaler.getHeight(0)),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                  '''International Baccalaureate (IB), SAT / AP in USA, SMA Ujian Nasional in Indonesia, etc, ''',
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                      TextStyle(fontSize: 14, color: Color(0xff6747CD))),
                                                ),
                                                TextSpan(
                                                  text: 'click',
                                                  style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                        fontSize: 14,
                                                        decoration: TextDecoration.underline,
                                                        color: Color(0xff6747CD),
                                                      )),
                                                  recognizer: new TapGestureRecognizer()
                                                    ..onTap = () {
                                                      launch(
                                                          'https://ugapply.cuhk.edu.cn/files/link/508796007e534e41857319f409a2c9dd.pdf');
                                                    },
                                                ),
                                                TextSpan(
                                                  text: ''' here for more detailed info, if you have no plan, please input no.''',
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                      TextStyle(fontSize: 14, color: Color(0xff6747CD))),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // National TextField
                                        Container(
                                          width: scaler.getWidth(80),
                                          height: scaler.getWidth(10),
                                          child: TextFormField(
                                            validator: (input) {
                                              if (input.isEmpty) {
                                                return '';
                                              }
                                            },
                                            onSaved: (input) {
                                              nationalExam = input;
                                            },
                                            initialValue: nationalExam,
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(fontSize: 16)),
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                left: scaler.getHeight(1),
                                              ),
                                              counterText: '',
                                              hintText: 'Aa',
                                              hintStyle: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                    fontSize: 16,
                                                  )),
                                              errorStyle: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 16,
                                                      height: 0
                                                  )),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Color(0xff6747CD))),
                                              focusColor: Color(0xff6747CD),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Color(0xff6747CD),
                                                      width: 1)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Color(0xff6747CD),
                                                      width: 1)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    //Add qualifications Text
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: scaler.getWidth(1),
                                          bottom: scaler.getWidth(.5)),
                                      child: RichText(
                                          text: TextSpan(
                                              text:
                                              '''4.1 Add Academic Qualifications (Secondary Level & Post-Secondary if any).'''
                                                  .trim(),
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold),
                                                  color: Colors.black),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: "*",
                                                  style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                          color: Color(0xff6747CD))),
                                                )
                                              ])),
                                    ),
                                    //Row 2 Awarding Institution
                                    Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            //Awarding  Inst Text
                                            Container(
                                              height: scaler.getWidth(5),
                                              margin: EdgeInsets.only(
                                                  top: scaler.getWidth(1),
                                                  bottom: scaler.getWidth(.5)),
                                              child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: RichText(
                                                      text: TextSpan(
                                                          text: "Awarding Institution",
                                                          style: GoogleFonts.lato(
                                                              textStyle: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                  FontWeight.bold),
                                                              color: Colors.black),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: "*",
                                                              style: GoogleFonts.lato(
                                                                  textStyle: TextStyle(
                                                                      fontSize: 18,
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                      color:
                                                                      Color(0xff6747CD))),
                                                            )
                                                          ]))),
                                            ),
                                            // Awarding Institution TextField
                                            Container(
                                              width: scaler.getWidth(80),
                                              height: scaler.getWidth(10),
                                              child: TextFormField(
                                                validator: (input) {
                                                  if (input.isEmpty) {
                                                    return '';
                                                  }
                                                },
                                                onSaved: (input) {
                                                  awardingInstitution = input;
                                                },
                                                initialValue: awardingInstitution,
                                                style: GoogleFonts.lato(
                                                    textStyle: TextStyle(fontSize: 16)),
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.only(
                                                    left: scaler.getHeight(1),
                                                  ),
                                                  counterText: '',
                                                  hintText: 'Aa',
                                                  hintStyle: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                        fontSize: 16,
                                                      )),
                                                  errorStyle: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontSize: 16,
                                                          height: 0
                                                      )),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                      borderSide: BorderSide(
                                                          color: Color(0xff6747CD))),
                                                  focusColor: Color(0xff6747CD),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                      borderSide: BorderSide(
                                                          color: Color(0xff6747CD),
                                                          width: 1)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                      borderSide: BorderSide(
                                                          color: Color(0xff6747CD),
                                                          width: 1)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                        // Number Container
                                      ],
                                    ),
                                    //Padding
                                    SizedBox(
                                      height: scaler.getWidth(1),
                                    ),
                                    //Row 3 Country
                                    Row(
                                      children: <Widget>[
                                        // Country Code Container
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            // Country Text
                                            Container(
                                              height: scaler.getWidth(5),
                                              margin: EdgeInsets.only(
                                                  top: scaler.getWidth(1),
                                                  bottom: scaler.getWidth(.5)),
                                              child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: RichText(
                                                      text: TextSpan(
                                                          text: "Country",
                                                          style: GoogleFonts.lato(
                                                              textStyle: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                  FontWeight.bold),
                                                              color: Colors.black),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: "*",
                                                              style: GoogleFonts.lato(
                                                                  textStyle: TextStyle(
                                                                      fontSize: 18,
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                      color:
                                                                      Color(0xff6747CD))),
                                                            )
                                                          ]))),
                                            ),
                                            // Country Institution Field
                                            Container(
                                                padding: EdgeInsets.only(
                                                    right: scaler.getHeight(.5)),
                                                alignment: Alignment.centerRight,
                                                height: scaler.getHeight(5),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Color(0xff6747CD),
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(10)),
                                                child: Container(
                                                  width: scaler.getWidth(80),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      SizedBox(width: 8.0),
                                                      CountryPickerUtils
                                                          .getDefaultFlagImage(countryI),
                                                      SizedBox(width: 8.0),
                                                      Container(
                                                          width: scaler.getWidth(60),
                                                          child: Text(
                                                            countryI.name,
                                                            textAlign: TextAlign.left,
                                                            style: GoogleFonts.lato(
                                                                textStyle: TextStyle(
                                                                    fontSize: 16,
                                                                    color: Colors.black,
                                                                    fontWeight:
                                                                    FontWeight.bold)),
                                                          )),
                                                      Expanded(child: SizedBox(width: 8.0)),
                                                      GestureDetector(
                                                        onTap: _openCountryPickerDialog,
                                                        child: Icon(
                                                          Icons.keyboard_arrow_down,
                                                          color: Color(0xff6747CD),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                    //Row 3 Study Mode
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // Study Mode Text
                                        Container(
                                          height: scaler.getWidth(5),
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: "Study Mode",
                                                      style: GoogleFonts.lato(
                                                          textStyle: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                          color: Colors.black),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: "*",
                                                          style: GoogleFonts.lato(
                                                              textStyle: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  color:
                                                                  Color(0xff6747CD))),
                                                        )
                                                      ]))),
                                        ),

                                        // Study Mode Field
                                        Container(
                                          width: scaler.getWidth(28),
                                          height: scaler.getWidth(10),
                                          child: DropdownButtonFormField(
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  left: scaler.getWidth(3)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Color(0xff6747CD))),
                                              focusColor: Color(0xff6747CD),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Color(0xff6747CD),
                                                      width: 1)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Color(0xff6747CD),
                                                      width: 1)),
                                            ),
                                            value: dropdownStudy,
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color(0xff6747CD),
                                            ),
                                            iconSize: 24,
                                            elevation: 16,
                                            onChanged: (String newValue) {
                                              setState(() {
                                                print(newValue);
                                                dropdownStudy = newValue;
                                              });
                                            },
                                            items: <String>[
                                              'Full-Time',
                                              'Part-Time',
                                            ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: GoogleFonts.lato(
                                                          textStyle: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors.black)),
                                                    ),
                                                  );
                                                }).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    //Date of Attendence Text
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: scaler.getWidth(1),
                                          bottom: scaler.getWidth(.5)),
                                      child: RichText(
                                          text: TextSpan(
                                              text:
                                              '''Date of Attendence'''
                                                  .trim(),
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold),
                                                  color: Colors.black),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: "*",
                                                  style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                          color: Color(0xff6747CD))),
                                                )
                                              ])),
                                    ),
                                    //To & From Date Field
                                    Row(
                                      children: <Widget>[
                                        //From Date Field
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              height: scaler.getWidth(5),
                                              margin: EdgeInsets.only(
                                                  top: scaler.getWidth(1),
                                                  bottom: scaler.getWidth(.5)),
                                              child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: RichText(
                                                      text: TextSpan(
                                                          text: "From",
                                                          style: GoogleFonts.lato(
                                                              textStyle: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                  FontWeight.bold),
                                                              color: Colors.black),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: "*",
                                                              style: GoogleFonts.lato(
                                                                  textStyle: TextStyle(
                                                                      fontSize: 18,
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                      color:
                                                                      Color(0xff6747CD))),
                                                            )
                                                          ]))),
                                            ),

                                            // Date Fields
                                            Container(
                                                width: scaler.getHeight(18),
                                                height: scaler.getWidth(10),
                                                padding: EdgeInsets.only(
                                                    right: scaler.getHeight(.5)),
                                                alignment: Alignment.centerRight,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Color(0xff6747CD),
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(10)),
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            "${attendenceFrom.toLocal()}".split(' ')[0],
                                                            textAlign: TextAlign.right,
                                                            style: GoogleFonts.lato(
                                                                textStyle: TextStyle(
                                                                    fontSize: 16,
                                                                    color: Colors.black,
                                                                    fontWeight:
                                                                    FontWeight.bold)),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 8.0),
                                                      GestureDetector(
                                                        child: Icon(
                                                          Icons.keyboard_arrow_down,
                                                          color: Color(0xff6747CD),
                                                        ),
                                                        onTap:() => _selectAttendenceFrom(context),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                        //Padding
                                        SizedBox(
                                          width: scaler.getWidth(10),
                                        ),
                                        //To Date Field
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            // Date of Birth Text
                                            Container(
                                              height: scaler.getWidth(5),
                                              margin: EdgeInsets.only(
                                                  top: scaler.getWidth(1),
                                                  bottom: scaler.getWidth(.5)),
                                              child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: RichText(
                                                      text: TextSpan(
                                                          text: "To",
                                                          style: GoogleFonts.lato(
                                                              textStyle: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                  FontWeight.bold),
                                                              color: Colors.black),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: "*",
                                                              style: GoogleFonts.lato(
                                                                  textStyle: TextStyle(
                                                                      fontSize: 18,
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                      color:
                                                                      Color(0xff6747CD))),
                                                            )
                                                          ]))),
                                            ),

                                            // Date Fields
                                            Container(
                                                width: scaler.getHeight(18),
                                                height: scaler.getWidth(10),
                                                padding: EdgeInsets.only(
                                                    right: scaler.getHeight(.5)),
                                                alignment: Alignment.centerRight,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Color(0xff6747CD),
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(10)),
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            "${attendenceTo.toLocal()}".split(' ')[0],
                                                            textAlign: TextAlign.right,
                                                            style: GoogleFonts.lato(
                                                                textStyle: TextStyle(
                                                                    fontSize: 16,
                                                                    color: Colors.black,
                                                                    fontWeight:
                                                                    FontWeight.bold)),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 8.0),
                                                      GestureDetector(
                                                        child: Icon(
                                                          Icons.keyboard_arrow_down,
                                                          color: Color(0xff6747CD),
                                                        ),
                                                        onTap:() => _selectAttendenceTo(context),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                    //Row 4 GPA
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //GPA Text
                                        Container(
                                          height: scaler.getWidth(5),
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              //bottom: scaler.getWidth(.5)
                                          ),
                                          child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: "Grades Record / Attendance GPA",
                                                      style: GoogleFonts.lato(
                                                          textStyle: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                          color: Colors.black),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: "*",
                                                          style: GoogleFonts.lato(
                                                              textStyle: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  color:
                                                                  Color(0xff6747CD))),
                                                        )
                                                      ]))),
                                        ),
                                        // Note Text
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(1),
                                              right: scaler.getHeight(.5),
                                              left: scaler.getHeight(0)),
                                          child: Text(
                                            '''(eg. 85 out of 100, 4.5 out of 5)'''.trim(),
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 14, color: Color(0xff6747CD))),
                                          ),
                                        ),
                                        // GPA TextField
                                        Container(
                                          width: scaler.getWidth(80),
                                          height: scaler.getWidth(10),
                                          child: TextFormField(
                                            validator: (input) {
                                              if (input.isEmpty) {
                                                return '';
                                              }
                                            },
                                            onSaved: (input) {
                                              gradesRecord = input;
                                            },
                                            initialValue: gradesRecord,
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(fontSize: 16)),
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                left: scaler.getHeight(1),
                                              ),
                                              counterText: '',
                                              hintText: 'Aa',
                                              hintStyle: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                    fontSize: 16,
                                                  )),
                                              errorStyle: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 16,
                                                      height: 0
                                                  )),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Color(0xff6747CD))),
                                              focusColor: Color(0xff6747CD),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Color(0xff6747CD),
                                                      width: 1)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Color(0xff6747CD),
                                                      width: 1)),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                    //Padding
                                    SizedBox(
                                      height: scaler.getWidth(1),
                                    ),

                                  ],
                                ),
                              ),
                              ArrowButtom(
                                onTap: () async {
                                  await registerEducationHistory();
                                },
                              )
                            ],
                          ))));
            }
            else{
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }
      ),
    );
  }

  Future<Null> _selectAttendenceTo(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: attendenceTo,
        firstDate: DateTime(1960, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != attendenceTo){
      setState(() {
        attendenceTo = picked;
        print("${attendenceTo.toLocal()}".split(' ')[0]);
      });}
  }

  Future<Null> _selectAttendenceFrom(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: attendenceFrom,
        firstDate: DateTime(1960, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != attendenceFrom){

      setState(() {
        attendenceFrom = picked;
        print("${attendenceFrom.toLocal()}".split(' ')[0]);
      });}
  }


  Widget _buildDialogItem(Country country) => Row(
    children: <Widget>[
      CountryPickerUtils.getDefaultFlagImage(country),
      SizedBox(width: 8.0),
      Flexible(
        child: Text(
          country.name,
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        ),
      )
    ],
  );
  void _openCountryPickerDialog() => showDialog(
    context: context,
    builder: (context) => Theme(
      data: Theme.of(context).copyWith(primaryColor: Color(0xff6747CD)),
      child: CountryPickerDialog(
        titlePadding: EdgeInsets.all(8.0),
        searchCursorColor: Color(0xff6747CD),
        searchInputDecoration: InputDecoration(hintText: 'Search...'),
        isSearchable: true,
        title: Text('Select country'),
        onValuePicked: (Country country) =>
            setState(() => countryInstitution = country.name),
        itemBuilder: _buildDialogItem,
      ),
    ),
  );


  Future<void> registerEducationHistory() async {
    {
      final formState = _formKey.currentState;
      widget.userBloc = BlocProvider.of(context);
      if (formState.validate()) {
        formState.save();
        try {
          widget.userBloc.registerEducationHistory(widget.userId, awardingInstitution, countryInstitution, "${attendenceTo.toLocal()}".split(' ')[0], "${attendenceFrom.toLocal()}".split(' ')[0], gradesRecord, nationalExam, dropdownStudy);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LanguageQualificationsPage(
                    userId: widget.userId,
                  )));

        } catch (e) {
          print(e.message);
          Navigator.of(context).pop();
        }
      }
      else{
        _scaffkey.currentState.showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            alignment: Alignment.center,
            child: Text(
              "Please don't leave any required field empty",
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 14,
                  )),
            ),
          ),
        ));
      }
    }
  }
}
