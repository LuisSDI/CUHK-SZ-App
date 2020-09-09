import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuhkszapp/MainPages/ApplyPages/references_page.dart';
import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';
import 'package:cuhkszapp/resources/arrow_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:path/path.dart' as path;

class LanguageQualificationsPage extends StatefulWidget {
  UserBloc userBloc;
  final String userId;

  LanguageQualificationsPage({Key key, this.userId}) : super(key: key);
  @override
  _LanguageQualificationsPageState createState() =>
      _LanguageQualificationsPageState();
}

class _LanguageQualificationsPageState
    extends State<LanguageQualificationsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffkey = GlobalKey();
  String dropdownEnglish;
  String dropdownQualificationState;
  String selectEnglishTest;
  DateTime dateTaken;
  String totalScore;
  String tentativeEnglishTest;
  String dropdownChinese;
  String lengthChineseStudy;
  String placeStudy;
  String dropdownProficiency;
  String otherLanguages;
  List<Widget> gridItems = [];
  List<String> languageFilenames = [];
  List<String> languageUrls = [];
  Widget dotted;

  Stream<DocumentSnapshot> _stream;

  @override
  void initState() {
    // Only create the stream once
    _stream = UserBloc().getLanguageQualifications(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: UserBloc(),
      child: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                Map languageQualifications = snapshot.data.data;
                if (languageQualifications != null) {
                  dropdownEnglish ??=
                      languageQualifications['english first language'];
                  dropdownQualificationState ??=
                      languageQualifications['has english qualification'];
                  selectEnglishTest =
                      languageQualifications['english qualification'];
                  dateTaken =
                      DateTime.parse(languageQualifications['date taken']);
                  totalScore = languageQualifications['total score'];
                  tentativeEnglishTest =
                      languageQualifications['tentative english qualification'];
                  dropdownChinese ??=
                      languageQualifications['has chinese experience'];
                  lengthChineseStudy =
                      languageQualifications['length chinese study'];
                  placeStudy = languageQualifications['place chinese study'];
                  dropdownProficiency ??=
                      languageQualifications['chinese proficiency'];
                  otherLanguages = languageQualifications['other languages'];
                  languageFilenames =
                      languageQualifications['language qualifications name']
                          .cast<String>();
                  languageUrls =
                      languageQualifications['language qualifications urls']
                          .cast<String>();
                }
              }
              print(dropdownEnglish);
              print(dropdownQualificationState);
              dateTaken ??= DateTime.now();
              dropdownEnglish ??= 'Yes';
              dropdownChinese ??= 'Yes';
              if (dropdownEnglish == 'No') {
                dropdownQualificationState ??=
                    'Yes, I have a required English qualification';
              }
              //
              if (dropdownChinese == 'No') {
                dropdownProficiency ??= 'Fluent';
              }

              ScreenScaler scaler = ScreenScaler()..init(context);
              dotted = Padding(
                padding: const EdgeInsets.all(8.0),
                child: DottedBorder(
                  color: Color(0xff6747CD),
                  strokeWidth: 2,
                  dashPattern: [8, 4],
                  borderType: BorderType.RRect,
                  radius: Radius.circular(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: Container(
                      width: scaler.getWidth(25),
                      height: scaler.getHeight(21),
                      child: Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () async {
                            List<File> files = await FilePicker.getMultiFile(
                              type: FileType.custom,
                              allowedExtensions: ['pdf'],
                            );
                            List<File> filesToUpload = [];
                            for (var file in files) {
                              String filename = path.basename(file.path);
                              if (languageFilenames.contains(filename)) {
                              } else {
                                languageFilenames.add(filename);
                                filesToUpload.add(file);
                              }
                            }
                            uploadLanguages(filesToUpload, languageFilenames);
                          },
                          child: Container(
                            height: scaler.getWidth(10),
                            width: scaler.getWidth(10),
                            padding: EdgeInsets.all(scaler.getWidth(1)),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xff6747CD),
                                      Color(0x8C3300D6)
                                    ]),
                                shape: BoxShape.circle),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
              gridItems.clear();
              for (var filename in languageFilenames) {
                gridItems.insert(0, fileWidget(filename, scaler));
              }
              gridItems.add(dotted);
              return Scaffold(
                  key: _scaffkey,
                  body: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                          child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              left: scaler.getWidth(2),
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    //Buttom for back
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: scaler.getWidth(6)),
                                      child: IconButton(
                                        icon: Icon(
                                          Ionicons.ios_arrow_back,
                                          color: Color(0xff6747CD),
                                          size: 30,
                                        ),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    ),
                                    //Title Text
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(
                                          top: scaler.getWidth(7)),
                                      child: Text(
                                        '''5. Language 
Qualifications'''
                                            .trim(),
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 31,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                ),

                                //5.1 Text
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // 5.1 Text
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: RichText(
                                              text: TextSpan(
                                            text:
                                                '''5.1 English Language \nQualifications / Proficiency.''',
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                color: Colors.black),
                                          )),
                                        ),
                                      ],
                                    )
                                    // Number Container
                                  ],
                                ),
                                //Question 2 of TextField
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // Is English Question Text
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: RichText(
                                              text: TextSpan(
                                                  text:
                                                      '''Is English your first language?'''
                                                          .trim(),
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
                                                          color: Color(
                                                              0xff6747CD))),
                                                )
                                              ])),
                                        ),
                                        // Question  Dropdown
                                        Container(
                                          width: scaler.getWidth(18),
                                          height: scaler.getWidth(10),
                                          child: DropdownButtonFormField(
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  left: scaler.getWidth(3)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Color(0xff6747CD))),
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
                                            value: dropdownEnglish,
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color(0xff6747CD),
                                            ),
                                            iconSize: 24,
                                            elevation: 16,
                                            onChanged: (String newValue) {
                                              setState(() {
                                                dropdownEnglish = newValue;
                                              });
                                            },
                                            items: <String>[
                                              'Yes',
                                              'No',
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
                                        (dropdownEnglish == 'No')
                                            ? Row(
                                                children: <Widget>[
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      // Question 3 Text
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: scaler
                                                                .getWidth(1),
                                                            bottom: scaler
                                                                .getWidth(.5)),
                                                        child: RichText(
                                                            text: TextSpan(
                                                                text:
                                                                    '''Do you have any English qualifications?'''
                                                                        .trim(),
                                                                style: GoogleFonts.lato(
                                                                    textStyle: TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold),
                                                                    color: Colors
                                                                        .black),
                                                                children: <
                                                                    TextSpan>[
                                                              TextSpan(
                                                                text: "*",
                                                                style: GoogleFonts.lato(
                                                                    textStyle: TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Color(
                                                                            0xff6747CD))),
                                                              )
                                                            ])),
                                                      ),
                                                      // Question Qualification Dropdown
                                                      Container(
                                                        width:
                                                            scaler.getWidth(88),
                                                        height:
                                                            scaler.getWidth(10),
                                                        child:
                                                            DropdownButtonFormField(
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    left: scaler
                                                                        .getWidth(
                                                                            3)),
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                borderSide: BorderSide(
                                                                    color: Color(
                                                                        0xff6747CD))),
                                                            focusColor: Color(
                                                                0xff6747CD),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                borderSide:
                                                                    BorderSide(
                                                                        color: Color(
                                                                            0xff6747CD),
                                                                        width:
                                                                            1)),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                borderSide:
                                                                    BorderSide(
                                                                        color: Color(
                                                                            0xff6747CD),
                                                                        width:
                                                                            1)),
                                                          ),
                                                          value:
                                                              dropdownQualificationState,
                                                          icon: Icon(
                                                            Icons
                                                                .keyboard_arrow_down,
                                                            color: Color(
                                                                0xff6747CD),
                                                          ),
                                                          iconSize: 24,
                                                          elevation: 16,
                                                          onChanged: (String
                                                              newValue) {
                                                            setState(() {
                                                              dropdownQualificationState =
                                                                  newValue;
                                                            });
                                                          },
                                                          items: <String>[
                                                            'Yes, I have a required English qualification',
                                                            'No, but I will take one in the future',
                                                          ].map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: Text(
                                                                value,
                                                                style: GoogleFonts.lato(
                                                                    textStyle: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .black)),
                                                              ),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                      (dropdownQualificationState ==
                                                              'Yes, I have a required English qualification')
                                                          ?
                                                          //English Test Form
                                                          Row(
                                                              children: <
                                                                  Widget>[
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    //English Test Question
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: <
                                                                          Widget>[
                                                                        //English Test Text
                                                                        Container(
                                                                          height:
                                                                              scaler.getWidth(5),
                                                                          margin: EdgeInsets.only(
                                                                              top: scaler.getWidth(1),
                                                                              bottom: scaler.getWidth(.5)),
                                                                          child: RichText(
                                                                              text: TextSpan(text: "English Tests & Public Examinations", style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), color: Colors.black), children: <TextSpan>[
                                                                            TextSpan(
                                                                              text: "*",
                                                                              style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff6747CD))),
                                                                            )
                                                                          ])),
                                                                        ),
                                                                        //English Test TextField
                                                                        Container(
                                                                          width:
                                                                              scaler.getWidth(88),
                                                                          height:
                                                                              scaler.getWidth(10),
                                                                          child:
                                                                              TextFormField(
                                                                            validator:
                                                                                (input) {
                                                                              if (input.isEmpty) {
                                                                                return '';
                                                                              }
                                                                            },
                                                                            onSaved:
                                                                                (input) {
                                                                              selectEnglishTest = input;
                                                                            },
                                                                            initialValue:
                                                                                selectEnglishTest,
                                                                            style:
                                                                                GoogleFonts.lato(textStyle: TextStyle(fontSize: 16)),
                                                                            decoration:
                                                                                InputDecoration(
                                                                              contentPadding: EdgeInsets.only(
                                                                                left: scaler.getHeight(1),
                                                                              ),
                                                                              counterText: '',
                                                                              hintText: 'Aa',
                                                                              hintStyle: GoogleFonts.lato(
                                                                                  textStyle: TextStyle(
                                                                                fontSize: 16,
                                                                              )),
                                                                              errorStyle: GoogleFonts.lato(textStyle: TextStyle(fontSize: 16, height: 0)),
                                                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Color(0xff6747CD))),
                                                                              focusColor: Color(0xff6747CD),
                                                                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Color(0xff6747CD), width: 1)),
                                                                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Color(0xff6747CD), width: 1)),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        // Note Text
                                                                        Container(
                                                                          margin: EdgeInsets.only(
                                                                              top: scaler.getWidth(1),
                                                                              bottom: scaler.getWidth(1),
                                                                              right: scaler.getHeight(.5),
                                                                              left: scaler.getHeight(0)),
                                                                          child:
                                                                              Text(
                                                                            '''Please specify which English qualification you have \ntaken (e.g. IELTS/TOEFL)'''.trim(),
                                                                            style:
                                                                                GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff6747CD))),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    //Date Taken & Score
                                                                    Row(
                                                                      children: [
                                                                        //Date Taken
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            //Date Taken Text
                                                                            Container(
                                                                              margin: EdgeInsets.only(bottom: scaler.getWidth(.5)),
                                                                              alignment: Alignment.centerLeft,
                                                                              child: RichText(
                                                                                  text: TextSpan(text: '''Date Taken:'''.trim(), style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), color: Colors.black), children: <TextSpan>[
                                                                                TextSpan(
                                                                                  text: "*",
                                                                                  style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff6747CD))),
                                                                                )
                                                                              ])),
                                                                            ),
                                                                            //Date Field
                                                                            Row(
                                                                              children: <Widget>[
                                                                                //From Date Field
                                                                                Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: <Widget>[
                                                                                    // Date Fields
                                                                                    Container(
                                                                                        width: scaler.getHeight(18),
                                                                                        height: scaler.getWidth(10),
                                                                                        padding: EdgeInsets.only(right: scaler.getHeight(.5)),
                                                                                        alignment: Alignment.centerRight,
                                                                                        decoration: BoxDecoration(
                                                                                            border: Border.all(
                                                                                              color: Color(0xff6747CD),
                                                                                            ),
                                                                                            borderRadius: BorderRadius.circular(10)),
                                                                                        child: Container(
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: <Widget>[
                                                                                              Expanded(
                                                                                                child: Container(
                                                                                                  alignment: Alignment.center,
                                                                                                  child: Text(
                                                                                                    "${dateTaken.toLocal()}".split(' ')[0],
                                                                                                    textAlign: TextAlign.right,
                                                                                                    style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(width: 8.0),
                                                                                              GestureDetector(
                                                                                                child: Icon(
                                                                                                  Icons.keyboard_arrow_down,
                                                                                                  color: Color(0xff6747CD),
                                                                                                ),
                                                                                                onTap: () => _selectDateTaken(context),
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                        )),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        //Padding
                                                                        SizedBox(
                                                                            width:
                                                                                scaler.getWidth(5)),
                                                                        //Score Question
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: <
                                                                              Widget>[
                                                                            //Total Score Text
                                                                            Container(
                                                                              margin: EdgeInsets.only(bottom: scaler.getWidth(.5)),
                                                                              child: RichText(
                                                                                  text: TextSpan(text: "Total Score:", style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), color: Colors.black), children: <TextSpan>[
                                                                                TextSpan(
                                                                                  text: "*",
                                                                                  style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff6747CD))),
                                                                                )
                                                                              ])),
                                                                            ),
                                                                            //English Test TextField
                                                                            Container(
                                                                              width: scaler.getWidth(30),
                                                                              height: scaler.getWidth(10),
                                                                              child: TextFormField(
                                                                                validator: (input) {
                                                                                  if (input.isEmpty) {
                                                                                    return '';
                                                                                  }
                                                                                },
                                                                                onSaved: (input) {
                                                                                  totalScore = input;
                                                                                },
                                                                                initialValue: totalScore,
                                                                                style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 16)),
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
                                                                                  errorStyle: GoogleFonts.lato(textStyle: TextStyle(fontSize: 16, height: 0)),
                                                                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Color(0xff6747CD))),
                                                                                  focusColor: Color(0xff6747CD),
                                                                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Color(0xff6747CD), width: 1)),
                                                                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Color(0xff6747CD), width: 1)),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    //To & From Date Field
                                                                  ],
                                                                )
                                                                // Number Container
                                                              ],
                                                            )
                                                          :
                                                          //English Test Question
                                                          Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                //English Test Text
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                      top: scaler
                                                                          .getWidth(
                                                                              1),
                                                                      bottom: scaler
                                                                          .getWidth(
                                                                              .5)),
                                                                  child:
                                                                      RichText(
                                                                          text: TextSpan(
                                                                              text: "Please advise what English language test \nwill you take and when the result is \nexfected.",
                                                                              style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), color: Colors.black),
                                                                              children: <TextSpan>[
                                                                        TextSpan(
                                                                          text:
                                                                              "*",
                                                                          style:
                                                                              GoogleFonts.lato(textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff6747CD))),
                                                                        )
                                                                      ])),
                                                                ),
                                                                //English Test TextField
                                                                Container(
                                                                  width: scaler
                                                                      .getWidth(
                                                                          88),
                                                                  height: scaler
                                                                      .getWidth(
                                                                          10),
                                                                  child:
                                                                      TextFormField(
                                                                    validator:
                                                                        (input) {
                                                                      if (input
                                                                          .isEmpty) {
                                                                        return '';
                                                                      }
                                                                    },
                                                                    onSaved:
                                                                        (input) {
                                                                      tentativeEnglishTest =
                                                                          input;
                                                                    },
                                                                    initialValue:
                                                                        tentativeEnglishTest,
                                                                    style: GoogleFonts.lato(
                                                                        textStyle:
                                                                            TextStyle(fontSize: 16)),
                                                                    decoration:
                                                                        InputDecoration(
                                                                      contentPadding:
                                                                          EdgeInsets
                                                                              .only(
                                                                        left: scaler
                                                                            .getHeight(1),
                                                                      ),
                                                                      counterText:
                                                                          '',
                                                                      hintText:
                                                                          'Aa',
                                                                      hintStyle:
                                                                          GoogleFonts.lato(
                                                                              textStyle: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                      )),
                                                                      errorStyle: GoogleFonts.lato(
                                                                          textStyle: TextStyle(
                                                                              fontSize: 16,
                                                                              height: 0)),
                                                                      border: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              10),
                                                                          borderSide:
                                                                              BorderSide(color: Color(0xff6747CD))),
                                                                      focusColor:
                                                                          Color(
                                                                              0xff6747CD),
                                                                      focusedBorder: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              10),
                                                                          borderSide: BorderSide(
                                                                              color: Color(0xff6747CD),
                                                                              width: 1)),
                                                                      enabledBorder: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              10),
                                                                          borderSide: BorderSide(
                                                                              color: Color(0xff6747CD),
                                                                              width: 1)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                    ],
                                                  )
                                                  // Number Container
                                                ],
                                              )
                                            : Container(),
                                      ],
                                    )
                                    // Number Container
                                  ],
                                ),
                                //Padding
                                SizedBox(
                                  height: scaler.getWidth(1),
                                ),
                                //Chinese Level
                                //5.2 Text
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // 5.2 Text
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: RichText(
                                              text: TextSpan(
                                            text: '''5.2 Chinese Level''',
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                color: Colors.black),
                                          )),
                                        ),
                                      ],
                                    )
                                    // Number Container
                                  ],
                                ),
                                //Question 2 of TextField
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // Is English Question Text
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: RichText(
                                              text: TextSpan(
                                                  text:
                                                      '''Do you have any experience in learning \nChinese?'''
                                                          .trim(),
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
                                                          color: Color(
                                                              0xff6747CD))),
                                                )
                                              ])),
                                        ),
                                        // Question  Dropdown
                                        Container(
                                          width: scaler.getWidth(18),
                                          height: scaler.getWidth(10),
                                          child: DropdownButtonFormField(
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  left: scaler.getWidth(3)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Color(0xff6747CD))),
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
                                            value: dropdownChinese,
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color(0xff6747CD),
                                            ),
                                            iconSize: 24,
                                            elevation: 16,
                                            onChanged: (String newValue) {
                                              setState(() {
                                                dropdownChinese = newValue;
                                              });
                                            },
                                            items: <String>[
                                              'Yes',
                                              'No',
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
                                        (dropdownChinese == 'Yes')
                                            ? Row(
                                                children: <Widget>[
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      //Length Chinese Question
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          //Length of Chinese Text
                                                          Container(
                                                            height: scaler
                                                                .getWidth(5),
                                                            margin: EdgeInsets.only(
                                                                top: scaler
                                                                    .getWidth(
                                                                        1),
                                                                bottom: scaler
                                                                    .getWidth(
                                                                        .5)),
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    text:
                                                                        "Length of Chinese Study:",
                                                                    style: GoogleFonts.lato(
                                                                        textStyle: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight: FontWeight
                                                                                .bold),
                                                                        color: Colors
                                                                            .black),
                                                                    children: <
                                                                        TextSpan>[
                                                                  TextSpan(
                                                                    text: "*",
                                                                    style: GoogleFonts.lato(
                                                                        textStyle: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Color(0xff6747CD))),
                                                                  )
                                                                ])),
                                                          ),
                                                          //Length of Chinese Study TextField
                                                          Container(
                                                            width: scaler
                                                                .getWidth(48),
                                                            height: scaler
                                                                .getWidth(10),
                                                            child:
                                                                TextFormField(
                                                              validator:
                                                                  (input) {
                                                                if (input
                                                                    .isEmpty) {
                                                                  return '';
                                                                }
                                                              },
                                                              onSaved: (input) {
                                                                lengthChineseStudy =
                                                                    input;
                                                              },
                                                              initialValue:
                                                                  lengthChineseStudy,
                                                              style: GoogleFonts.lato(
                                                                  textStyle:
                                                                      TextStyle(
                                                                          fontSize:
                                                                              16)),
                                                              decoration:
                                                                  InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: scaler
                                                                      .getHeight(
                                                                          1),
                                                                ),
                                                                counterText: '',
                                                                hintText: 'Aa',
                                                                hintStyle: GoogleFonts
                                                                    .lato(
                                                                        textStyle:
                                                                            TextStyle(
                                                                  fontSize: 16,
                                                                )),
                                                                errorStyle: GoogleFonts.lato(
                                                                    textStyle: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        height:
                                                                            0)),
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Color(0xff6747CD))),
                                                                focusColor: Color(
                                                                    0xff6747CD),
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xff6747CD),
                                                                        width:
                                                                            1)),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xff6747CD),
                                                                        width:
                                                                            1)),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      //Place of Chinese Question
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          //Length of Chinese Text
                                                          Container(
                                                            height: scaler
                                                                .getWidth(5),
                                                            margin: EdgeInsets.only(
                                                                top: scaler
                                                                    .getWidth(
                                                                        1),
                                                                bottom: scaler
                                                                    .getWidth(
                                                                        .5)),
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    text:
                                                                        "Place of Chinese Study:",
                                                                    style: GoogleFonts.lato(
                                                                        textStyle: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight: FontWeight
                                                                                .bold),
                                                                        color: Colors
                                                                            .black),
                                                                    children: <
                                                                        TextSpan>[
                                                                  TextSpan(
                                                                    text: "*",
                                                                    style: GoogleFonts.lato(
                                                                        textStyle: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Color(0xff6747CD))),
                                                                  )
                                                                ])),
                                                          ),
                                                          //Length of Chinese Study TextField
                                                          Container(
                                                            width: scaler
                                                                .getWidth(48),
                                                            height: scaler
                                                                .getWidth(10),
                                                            child:
                                                                TextFormField(
                                                              validator:
                                                                  (input) {
                                                                if (input
                                                                    .isEmpty) {
                                                                  return '';
                                                                }
                                                              },
                                                              onSaved: (input) {
                                                                placeStudy =
                                                                    input;
                                                              },
                                                              initialValue:
                                                                  placeStudy,
                                                              style: GoogleFonts.lato(
                                                                  textStyle:
                                                                      TextStyle(
                                                                          fontSize:
                                                                              16)),
                                                              decoration:
                                                                  InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: scaler
                                                                      .getHeight(
                                                                          1),
                                                                ),
                                                                counterText: '',
                                                                hintText: 'Aa',
                                                                hintStyle: GoogleFonts
                                                                    .lato(
                                                                        textStyle:
                                                                            TextStyle(
                                                                  fontSize: 16,
                                                                )),
                                                                errorStyle: GoogleFonts.lato(
                                                                    textStyle: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        height:
                                                                            0)),
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Color(0xff6747CD))),
                                                                focusColor: Color(
                                                                    0xff6747CD),
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xff6747CD),
                                                                        width:
                                                                            1)),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0xff6747CD),
                                                                        width:
                                                                            1)),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      // Question Proficiency Text
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: scaler
                                                                .getWidth(1),
                                                            bottom: scaler
                                                                .getWidth(.5)),
                                                        child: RichText(
                                                            text: TextSpan(
                                                                text:
                                                                    '''Proficiency:'''
                                                                        .trim(),
                                                                style: GoogleFonts.lato(
                                                                    textStyle: TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold),
                                                                    color: Colors
                                                                        .black),
                                                                children: <
                                                                    TextSpan>[
                                                              TextSpan(
                                                                text: "*",
                                                                style: GoogleFonts.lato(
                                                                    textStyle: TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Color(
                                                                            0xff6747CD))),
                                                              )
                                                            ])),
                                                      ),
                                                      // Question Proficiency Dropdown
                                                      Container(
                                                        width:
                                                            scaler.getWidth(28),
                                                        height:
                                                            scaler.getWidth(10),
                                                        child:
                                                            DropdownButtonFormField(
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    left: scaler
                                                                        .getWidth(
                                                                            3)),
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                borderSide: BorderSide(
                                                                    color: Color(
                                                                        0xff6747CD))),
                                                            focusColor: Color(
                                                                0xff6747CD),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                borderSide:
                                                                    BorderSide(
                                                                        color: Color(
                                                                            0xff6747CD),
                                                                        width:
                                                                            1)),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                borderSide:
                                                                    BorderSide(
                                                                        color: Color(
                                                                            0xff6747CD),
                                                                        width:
                                                                            1)),
                                                          ),
                                                          value:
                                                              dropdownProficiency,
                                                          icon: Icon(
                                                            Icons
                                                                .keyboard_arrow_down,
                                                            color: Color(
                                                                0xff6747CD),
                                                          ),
                                                          iconSize: 24,
                                                          elevation: 16,
                                                          onChanged: (String
                                                              newValue) {
                                                            setState(() {
                                                              dropdownProficiency =
                                                                  newValue;
                                                            });
                                                          },
                                                          items: <String>[
                                                            'Fluent',
                                                            'Proficient',
                                                            'Other'
                                                          ].map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: Text(
                                                                value,
                                                                style: GoogleFonts.lato(
                                                                    textStyle: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .black)),
                                                              ),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                  // Number Container
                                                ],
                                              )
                                            : Container(),
                                      ],
                                    )
                                    // Number Container
                                  ],
                                ),
                                //Padding
                                SizedBox(
                                  height: scaler.getWidth(1),
                                ),
                                //Other Languages
                                //5.3 Text
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // 5.3 Text
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: RichText(
                                              text: TextSpan(
                                            text:
                                                '''5.3 Other Languages (if any)''',
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                color: Colors.black),
                                          )),
                                        ),
                                      ],
                                    )
                                    // Number Container
                                  ],
                                ),
                                //Question Other Languages of TextField
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //  Question Text
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: RichText(
                                              text: TextSpan(
                                            text:
                                                '''Please enter the other Languages below:'''
                                                    .trim(),
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                color: Colors.black),
                                          )),
                                        ),
                                        //Other Languages Question
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            //Length of Chinese Study TextField
                                            Container(
                                              width: scaler.getWidth(88),
                                              height: scaler.getWidth(10),
                                              child: TextFormField(
                                                onSaved: (input) {
                                                  otherLanguages = input;
                                                },
                                                initialValue: otherLanguages,
                                                style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                        fontSize: 16)),
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
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
                                                          height: 0)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xff6747CD))),
                                                  focusColor: Color(0xff6747CD),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xff6747CD),
                                                              width: 1)),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xff6747CD),
                                                              width: 1)),
                                                ),
                                              ),
                                            ),
                                          ],
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
                                //Upload Files
                                //5.4 Text
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // 5.4 Text
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: RichText(
                                              text: TextSpan(
                                            text: '''5.4 Documents''',
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                color: Colors.black),
                                          )),
                                        ),
                                      ],
                                    )
                                    // Number Container
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: scaler.getWidth(1),
                                      bottom: scaler.getWidth(.5)),
                                  child: RichText(
                                      text: TextSpan(
                                    text:
                                        '''Please upload your English test scores and HSK certificates (if any) in PDF format, if need it.'''
                                            .trim(),
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        color: Colors.black),
                                  )),
                                ),
                                GridView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: gridItems.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: (scaler.getWidth(25) /
                                        scaler.getHeight(20)),
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return gridItems[index];
                                  },
                                ),
                              ],
                            ),
                          ),
                          ArrowButtom(
                            onTap: () async {
                              await registerLanguageQualifications();
                            },
                          )
                        ],
                      ))));
            } else {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }

  Future<Null> _selectDateTaken(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dateTaken,
        firstDate: DateTime(1960, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateTaken) {
      setState(() {
        dateTaken = picked;
        print("${dateTaken.toLocal()}".split(' ')[0]);
      });
    }
  }

  Widget fileWidget(String filename, ScreenScaler scaler) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.bottomCenter,
            width: scaler.getWidth(25),
            height: scaler.getHeight(21),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xff6747CD), width: 2),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(scaler.getWidth(2)),
                    child: FittedBox(
                        child:
                            Icon(AntDesign.pdffile1, color: Color(0xff6747CD))),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Color(0xff6747CD),
                  child: Text(
                    (filename.length < 10)
                        ? filename
                        : '${filename.substring(0, 8)}...',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.normal)),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: scaler.getWidth(17),
          bottom: scaler.getHeight(17),
          child: Container(
            width: scaler.getHeight(4),
            margin: EdgeInsets.all(scaler.getWidth(2)),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff6747CD),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff6747CD), Color(0x8C3300D6)]),
            ),
            child: GestureDetector(
              onTap: () async {
                widget.userBloc = BlocProvider.of(context);
                languageFilenames.remove(filename);
                widget.userBloc.deleteLanguageFile(widget.userId, filename);
                languageUrls = await widget.userBloc
                    .getOnlyLanguageUrl(widget.userId, languageFilenames);
                widget.userBloc.registerLanguageUrl(
                    widget.userId, languageUrls, languageFilenames);
                _scaffkey.currentState.showSnackBar(SnackBar(
                  duration: Duration(seconds: 2),
                  content: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Text(
                      "The file has been deleted from the server",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                        fontSize: 14,
                      )),
                    ),
                  ),
                ));
              },
              child: Icon(
                Icons.clear,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> uploadLanguages(
      List<File> files, List<String> transcriptFilenames) async {
    widget.userBloc = BlocProvider.of(context);
    try {
      for (int i = 0; i < files.length; i++) {
        languageUrls.add(await widget.userBloc
            .getUploadLanguageUrl(widget.userId, files[i]));
      }
      print(languageUrls);
      print('Aqui');
      print(transcriptFilenames);
      widget.userBloc.registerLanguageUrl(
          widget.userId, languageUrls, transcriptFilenames);
      print('Done');
      _scaffkey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.05,
          child: Text(
            "Your files have been upload to the server",
            style: GoogleFonts.lato(
                textStyle: TextStyle(
              fontSize: 14,
            )),
          ),
        ),
      ));
    } catch (e) {
      print(e.message);
      Navigator.of(context).pop();
    }
  }

  Future<void> registerLanguageQualifications() async {
    {
      final formState = _formKey.currentState;
      widget.userBloc = BlocProvider.of(context);
      if (formState.validate()) {
        formState.save();
        try {
          widget.userBloc.registerLanguageQualifications(
              widget.userId,
              dropdownEnglish,
              dropdownQualificationState,
              selectEnglishTest,
              "${dateTaken.toLocal()}".split(' ')[0],
              totalScore,
              tentativeEnglishTest,
              dropdownChinese,
              lengthChineseStudy,
              placeStudy,
              dropdownProficiency,
              otherLanguages);
          print('Success');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReferencesPage(
                        userId: widget.userId,
                      )));
        } catch (e) {
          print(e.message);
          Navigator.of(context).pop();
        }
      } else {
        _scaffkey.currentState.showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            alignment: Alignment.center,
            child: Text(
              "Please fulfill all the required fields",
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
