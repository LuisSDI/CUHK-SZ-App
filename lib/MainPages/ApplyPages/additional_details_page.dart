import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';
import 'package:cuhkszapp/resources/arrow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'application_photo_page.dart';

class AdditionalDetailsPage extends StatefulWidget {
  UserBloc userBloc;
  final String userId;

  AdditionalDetailsPage({Key key, this.userId}) : super(key: key);

  @override
  _AdditionalDetailsPageState createState() => _AdditionalDetailsPageState();
}

class _AdditionalDetailsPageState extends State<AdditionalDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffkey = GlobalKey();
  String dropdownTuition;
  String dropdownNeeds;
  String dropdownCriminal;
  String needsDetails;
  String criminalDetails;
  String dropdownAgent;
  String emailAgent;
  String nameAgent;
  Stream<DocumentSnapshot> _stream;

  @override
  void initState() {
    // Only create the stream once
    _stream = UserBloc().getAdditionalDetails(widget.userId);
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
                print(snapshot.data.data);
                Map additionalDetails = snapshot.data.data;
                dropdownTuition ??= additionalDetails['source of tuition'];
                dropdownNeeds ??= additionalDetails['special needs'];
                dropdownCriminal ??= additionalDetails['criminal convictions'];
                dropdownAgent ??= additionalDetails['uses agent'];
                needsDetails = additionalDetails['needs details'];
                criminalDetails = additionalDetails['criminal details'];
                nameAgent = additionalDetails['name of agent'];
                emailAgent = additionalDetails['email of agent'];
              }
              dropdownTuition ??= 'Self-Support or Family Support';
              dropdownNeeds ??= 'No';
              dropdownCriminal ??= 'No';
              dropdownAgent ??= 'No';
              ScreenScaler scaler = ScreenScaler()..init(context);
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
                                top: scaler.getWidth(7)),
                            child: Column(
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
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    ),
                                    //Title Text
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '''1.4 Financial Support'''.trim(),
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 31,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                ),
                                // Intro Text
                                Container(
                                  margin: EdgeInsets.only(
                                      top: scaler.getWidth(1),
                                      bottom: scaler.getWidth(1),
                                      right: scaler.getHeight(.5),
                                      left: scaler.getHeight(0)),
                                  child: Text(
                                    '''Whether you are applying for a CUHK Shenzhen scholarship or not, please select how else you intend to fund your fees.''',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff62626C))),
                                  ),
                                ),
                                //Question 1 of TextField
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // Question 1 Text
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: RichText(
                                              text: TextSpan(
                                                  text: '''Source of Tuition''',
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
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xff6747CD))),
                                                    )
                                                  ])),
                                        ),
                                        // Tuition Question TextField
                                        Container(
                                          width: scaler.getWidth(70),
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
                                            value: dropdownTuition,
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color(0xff6747CD),
                                            ),
                                            iconSize: 24,
                                            elevation: 16,
                                            onChanged: (String newValue) {
                                              setState(() {
                                                print(newValue);
                                                dropdownTuition = newValue;
                                              });
                                            },
                                            items: <String>[
                                              'Self-Support or Family Support',
                                              'Corporate/Employer Sponsor',
                                              'Home Government Scholarship',
                                              'Other',
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
                                    )
                                    // Number Container
                                  ],
                                ),
                                //Padding
                                SizedBox(
                                  height: scaler.getWidth(1),
                                ),
                                //Question 2 of TextField
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //1.5 Text
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '''1.5 Special Needs'''.trim(),
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 31,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                        // Special Needs Question Text
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: RichText(
                                              text: TextSpan(
                                                  text:
                                                      '''Do you have any special needs? Such 
as health issues, disabilities or 
support needs.'''
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
                                            value: dropdownNeeds,
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color(0xff6747CD),
                                            ),
                                            iconSize: 24,
                                            elevation: 16,
                                            onChanged: (String newValue) {
                                              setState(() {
                                                print(newValue);
                                                dropdownNeeds = newValue;
                                                if(dropdownNeeds == 'No'){
                                                  needsDetails = '';
                                                }
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
                                        (dropdownNeeds == 'Yes')
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
                                                                    '''Please provide details of any health issues, 
disabilities or support needs:'''
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
                                                      // Question 3 TextField
                                                      Container(
                                                        width:
                                                            scaler.getWidth(86),
                                                        margin: EdgeInsets.only(
                                                            right: scaler
                                                                .getWidth(3)),
                                                        child: TextFormField(
                                                          validator: (input) {
                                                            if (input.isEmpty) {
                                                              return '';
                                                            }
                                                          },
                                                          onSaved: (input) {
                                                            needsDetails = input;
                                                          },
                                                          initialValue:
                                                              needsDetails,
                                                          maxLines: 6,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          style: GoogleFonts.lato(
                                                              textStyle:
                                                                  TextStyle(
                                                                      fontSize:
                                                                          16)),
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    left: scaler
                                                                        .getWidth(
                                                                            1),
                                                                    top: scaler
                                                                        .getWidth(
                                                                            2)),
                                                            hintText: 'Aa',
                                                            counterText: '',
                                                            errorStyle: GoogleFonts.lato(
                                                                textStyle:
                                                                    TextStyle(
                                                                        fontSize:
                                                                            14)),
                                                            counterStyle:
                                                                GoogleFonts.lato(
                                                                    textStyle: TextStyle(
                                                                        fontSize:
                                                                            14)),
                                                            hintStyle: GoogleFonts
                                                                .lato(
                                                                    textStyle:
                                                                        TextStyle(
                                                              fontSize: 16,
                                                            )),
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
                                                        ),
                                                      ),
                                                      // Note Text
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: scaler
                                                                .getWidth(1),
                                                            bottom: scaler
                                                                .getWidth(.5)),
                                                        child: RichText(
                                                            text: TextSpan(
                                                                text:
                                                                '''This information will remain strictly confidential.'''
                                                                    .trim(),
                                                                style: GoogleFonts.lato(
                                                                    textStyle: TextStyle(
                                                                        fontSize:
                                                                        14,
                                                                        ),
                                                                    color: Color(0xff6747CD)),
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
                                                    ],
                                                  )
                                                  // Number Container
                                                ],
                                              )
                                            : Container()
                                      ],
                                    )
                                    // Number Container
                                  ],
                                ),
                                //Padding
                                SizedBox(
                                  height: scaler.getWidth(1),
                                ),
                                //Criminal Convictions of TextField
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //1.6 Text
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '''1.6 Criminal Convictions'''.trim(),
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 31,
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.bold)),
                                          ),
                                        ),
                                        // Criminal Question Text
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: RichText(
                                              text: TextSpan(
                                                  text:
                                                  '''Have you ever been convicted of any 
crime?'''
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
                                        // Question  TextField
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
                                            value: dropdownCriminal,
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color(0xff6747CD),
                                            ),
                                            iconSize: 24,
                                            elevation: 16,
                                            onChanged: (String newValue) {
                                              setState(() {
                                                print(newValue);
                                                dropdownCriminal = newValue;
                                                if(dropdownCriminal == 'No'){
                                                  criminalDetails = '';
                                                }
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
                                        (dropdownCriminal == 'Yes')
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
                                                          '''Please provide details of your criminal 
conviction(s):'''
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
                                                // Question 3 TextField
                                                Container(
                                                  width:
                                                  scaler.getWidth(86),
                                                  margin: EdgeInsets.only(
                                                      right: scaler
                                                          .getWidth(3)),
                                                  child: TextFormField(
                                                    validator: (input) {
                                                      if (input.isEmpty) {
                                                        return '';
                                                      }
                                                    },
                                                    onSaved: (input) {
                                                      criminalDetails = input;
                                                    },
                                                    initialValue:
                                                    criminalDetails,
                                                    maxLines: 6,
                                                    keyboardType:
                                                    TextInputType
                                                        .text,
                                                    style: GoogleFonts.lato(
                                                        textStyle:
                                                        TextStyle(
                                                            fontSize:
                                                            16)),
                                                    decoration:
                                                    InputDecoration(
                                                      contentPadding:
                                                      EdgeInsets.only(
                                                          left: scaler
                                                              .getWidth(
                                                              1),
                                                          top: scaler
                                                              .getWidth(
                                                              2)),
                                                      hintText: 'Aa',
                                                      counterText: '',
                                                      errorStyle: GoogleFonts.lato(
                                                          textStyle:
                                                          TextStyle(
                                                              fontSize:
                                                              14,
                                                            height: 0
                                                          )),
                                                      counterStyle:
                                                      GoogleFonts.lato(
                                                          textStyle: TextStyle(
                                                              fontSize:
                                                              14)),
                                                      hintStyle: GoogleFonts
                                                          .lato(
                                                          textStyle:
                                                          TextStyle(
                                                            fontSize: 16,
                                                          )),
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
                                                  ),
                                                ),
                                                // Note Text
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: scaler
                                                          .getWidth(1),
                                                      bottom: scaler
                                                          .getWidth(.5)),
                                                  child: RichText(
                                                      text: TextSpan(
                                                          text:
                                                          '''This information will remain strictly confidential.'''
                                                              .trim(),
                                                          style: GoogleFonts.lato(
                                                              textStyle: TextStyle(
                                                                fontSize:
                                                                14,
                                                              ),
                                                              color: Color(0xff6747CD)),
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
                                              ],
                                            )
                                            // Number Container
                                          ],
                                        )
                                            : Container()
                                      ],
                                    )
                                    // Number Container
                                  ],
                                ),
                                //Padding
                                SizedBox(
                                  height: scaler.getWidth(1),
                                ),
                                //Agent Question
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //1.7 Text
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '''1.7 Are you applying 
through an agent?'''.trim(),
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 31,
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.bold)),
                                          ),
                                        ),
                                        // Agent Question Text
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: RichText(
                                              text: TextSpan(
                                                  text:
                                                  '''Please select:'''
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
                                        // Question  TextField
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
                                            value: dropdownAgent,
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color(0xff6747CD),
                                            ),
                                            iconSize: 24,
                                            elevation: 16,
                                            onChanged: (String newValue) {
                                              setState(() {
                                                print(newValue);
                                                dropdownAgent = newValue;
                                                if(dropdownAgent == 'No'){
                                                  nameAgent = null;
                                                  emailAgent = null;
                                                }
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
                                        (dropdownAgent == 'Yes')
                                            ? Row(
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        //Name Agent Text
                                                        Container(
                                                          height: scaler.getWidth(5),
                                                          margin: EdgeInsets.only(
                                                              top: scaler.getWidth(1),
                                                              bottom: scaler.getWidth(.5)),
                                                          child: FittedBox(
                                                              fit: BoxFit.contain,
                                                              child: RichText(
                                                                  text: TextSpan(
                                                                      text: "Name of Agent",
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
                                                        // Name of Agent TextField
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
                                                              nameAgent = input;
                                                            },
                                                            initialValue: nameAgent,
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
                                                Row(
                                                  children: <Widget>[
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        //Email of Agent Text
                                                        Container(
                                                          height: scaler.getWidth(5),
                                                          margin: EdgeInsets.only(
                                                              top: scaler.getWidth(1),
                                                              bottom: scaler.getWidth(.5)),
                                                          child: FittedBox(
                                                              fit: BoxFit.contain,
                                                              child: RichText(
                                                                  text: TextSpan(
                                                                      text: "Email of Agent",
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
                                                        // Email TextField
                                                        Container(
                                                          width: scaler.getWidth(80),
                                                          height: scaler.getWidth(10),
                                                          child: TextFormField(
                                                            validator: (input) {
                                                              if (!validateEmail(input)) {
                                                                _scaffkey.currentState.showSnackBar(SnackBar(
                                                                  duration: Duration(seconds: 1),
                                                                  content: Container(
                                                                    alignment: Alignment.center,
                                                                    height: MediaQuery.of(context).size.height * 0.05,
                                                                    child: Text(
                                                                      "Please enter a valid email address",
                                                                      style: GoogleFonts.lato(
                                                                          textStyle: TextStyle(
                                                                            fontSize: 14,
                                                                          )),
                                                                    ),
                                                                  ),
                                                                ));
                                                                return '';
                                                              }
                                                            },
                                                            onSaved: (input) {
                                                              emailAgent = input;
                                                            },
                                                            initialValue: emailAgent,
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
                                              ],
                                            )
                                            // Number Container
                                          ],
                                        )
                                            : Container()
                                      ],
                                    )
                                    // Number Container
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
                              await registerContactDetails();
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

  bool validateEmail(String value){
    String  pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }


  Future<void> registerContactDetails() async {
    {
      final formState = _formKey.currentState;
      widget.userBloc = BlocProvider.of(context);
      if (formState.validate()) {
        formState.save();
        try {
          widget.userBloc.registerAdditionalDetails(widget.userId, dropdownTuition, dropdownNeeds,
              needsDetails, dropdownCriminal, criminalDetails, dropdownAgent, nameAgent, emailAgent);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ApplicationPhotoPage(
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
