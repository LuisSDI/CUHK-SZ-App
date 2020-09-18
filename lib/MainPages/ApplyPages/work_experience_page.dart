import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:cuhkszapp/MainPages/ApplyPages/supporting_documents_page.dart';
import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';
import 'package:cuhkszapp/resources/arrow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkExpiriencePage extends StatefulWidget {
  UserBloc userBloc;
  final String userId;
  final GlobalKey<State> keyLoader = new GlobalKey<State>();

  WorkExpiriencePage({Key key, this.userId}) : super(key: key);

  @override
  _WorkExpiriencePageState createState() => _WorkExpiriencePageState();
}

class _WorkExpiriencePageState extends State<WorkExpiriencePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> _scaffkey = GlobalKey();

  String employersName;
  String positionHeld;
  String dropdownIsEmployer;
  String email;
  DateTime startDate;
  DateTime toDate;
  String residential;
  String city;
  String state;
  String postcode;
  String countryFirst;
  Stream<DocumentSnapshot> _stream;

  @override
  void initState() {
    // Only create the stream once
    _stream = UserBloc().getReferences(widget.userId);
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
                Map referencesDocument = snapshot.data.data;
                if (referencesDocument != null) {
                  Map firstReferee = referencesDocument['first referee'];
                  employersName = firstReferee['given name'];
                  positionHeld = firstReferee['family name'];
                  email = firstReferee['email'];
                  residential = firstReferee['street address'];
                  city = firstReferee['city'];
                  state = firstReferee['state'];
                  postcode = firstReferee['postcode'];
                  countryFirst = firstReferee['country'];
                }
              }
              ScreenScaler scaler = ScreenScaler()..init(context);
              dropdownIsEmployer ??= 'Yes';
              startDate ??= DateTime.now();
              toDate ??= DateTime.now();
              Country countryF;
              if (countryFirst != null) {
                countryF = CountryPickerUtils.getCountryByName(countryFirst);
              } else {
                countryF = CountryPickerUtils.getCountryByName('China');
              }

              return Scaffold(
                  key: _scaffkey,
                  body: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                          child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: scaler.getWidth(3),
                                top: scaler.getWidth(7)),
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
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    ),
                                    //Title Text
                                    Container(
                                      height: scaler.getHeight(5),
                                      alignment: Alignment.centerLeft,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          "7. Work Experience",
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
                                // Intro Text
                                Container(
                                  margin: EdgeInsets.only(
                                      top: scaler.getWidth(1),
                                      bottom: scaler.getWidth(1),
                                      right: scaler.getHeight(.5),
                                      left: scaler.getHeight(0)),
                                  child: Text(
                                    """Please add your current or previous work experience (if any)."""
                                        .trim(),
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff62626C))),
                                  ),
                                ),
                                //Row 1 Employers Name
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    //Employers Text
                                    Container(
                                      height: scaler.getWidth(5),
                                      margin: EdgeInsets.only(
                                          top: scaler.getWidth(1),
                                          bottom: scaler.getWidth(.5)),
                                      child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: RichText(
                                              text: TextSpan(
                                            text: "Employers Name",
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                color: Colors.black),
                                          ))),
                                    ),
                                    // Employer TextField
                                    Container(
                                      width: scaler.getWidth(80),
                                      height: scaler.getWidth(10),
                                      child: TextFormField(
                                        onSaved: (input) {
                                          employersName = input;
                                        },
                                        initialValue: employersName,
                                        maxLength: 15,
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
                                                  fontSize: 16, height: 0)),
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
                                //Row 2 Position
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    //Position Text
                                    Container(
                                      height: scaler.getWidth(5),
                                      margin: EdgeInsets.only(
                                          top: scaler.getWidth(1),
                                          bottom: scaler.getWidth(.5)),
                                      child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: RichText(
                                              text: TextSpan(
                                            text: "Position Held",
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                color: Colors.black),
                                          ))),
                                    ),
                                    // Organization TextField
                                    Container(
                                      width: scaler.getWidth(80),
                                      height: scaler.getWidth(10),
                                      child: TextFormField(
                                        onSaved: (input) {
                                          positionHeld = input;
                                        },
                                        initialValue: positionHeld,
                                        maxLength: 15,
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
                                                  fontSize: 16, height: 0)),
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
                                          height: scaler.getWidth(5),
                                          child: RichText(
                                              text: TextSpan(
                                            text:
                                                '''Is this your current employee?'''
                                                    .trim(),
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                color: Colors.black),
                                          )),
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
                                            value: dropdownIsEmployer,
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color(0xff6747CD),
                                            ),
                                            iconSize: 24,
                                            elevation: 16,
                                            onChanged: (String newValue) {
                                              setState(() {
                                                dropdownIsEmployer = newValue;
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
                                      ],
                                    )
                                    // Number Container
                                  ],
                                ),
                                //Row 5 Email
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //Email Text
                                        Container(
                                          height: scaler.getWidth(5),
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: RichText(
                                                  text: TextSpan(
                                                text: "Email",
                                                style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    color: Colors.black),
                                              ))),
                                        ),
                                        // Email TextField
                                        Container(
                                          width: scaler.getWidth(80),
                                          height: scaler.getWidth(10),
                                          child: TextFormField(
                                            onSaved: (input) {
                                              email = input;
                                            },
                                            initialValue: email,
                                            style: GoogleFonts.lato(
                                                textStyle:
                                                    TextStyle(fontSize: 16)),
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
                                                      fontSize: 16, height: 0)),
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
                                //To & From Date Field
                                Row(
                                  children: <Widget>[
                                    //From Date Field
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                text: "Start Date",
                                                style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    color: Colors.black),
                                              ))),
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
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "${startDate.toLocal()}"
                                                            .split(' ')[0],
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: GoogleFonts.lato(
                                                            textStyle: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.0),
                                                  GestureDetector(
                                                    child: Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color: Color(0xff6747CD),
                                                    ),
                                                    onTap: () =>
                                                        _selectStartDate(
                                                            context),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                text: "To Date",
                                                style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    color: Colors.black),
                                              ))),
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
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "${toDate.toLocal()}"
                                                            .split(' ')[0],
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: GoogleFonts.lato(
                                                            textStyle: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.0),
                                                  GestureDetector(
                                                    child: Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color: Color(0xff6747CD),
                                                    ),
                                                    onTap: () =>
                                                        _selectToDate(context),
                                                  )
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                                //Row Note
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Note Text
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: scaler.getWidth(1),
                                          right: scaler.getHeight(.5),
                                          left: scaler.getHeight(0)),
                                      child: Text(
                                        '''If possible, please provide the details of the Organisation below.'''
                                            .trim(),
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff6747CD))),
                                      ),
                                    ),
                                  ],
                                ),
                                //Street Address
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            //Street Address Text
                                            Container(
                                              height: scaler.getWidth(5),
                                              margin: EdgeInsets.only(
                                                  top: scaler.getWidth(1),
                                                  bottom: scaler.getWidth(.5)),
                                              child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: RichText(
                                                      text: TextSpan(
                                                    text: "Street Address",
                                                    style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                            fontSize: 17.5,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        color: Colors.black),
                                                  ))),
                                            ),
                                            // Street Address TextField
                                            Container(
                                              width: scaler.getWidth(80),
                                              height: scaler.getWidth(10),
                                              child: TextFormField(
                                                onSaved: (input) {
                                                  residential = input;
                                                },
                                                initialValue: residential,
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
                                        )
                                        // Number Container
                                      ],
                                    ),
                                    SizedBox(
                                      height: scaler.getWidth(1),
                                    ),
                                    //Row 8 City and State
                                    Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            //City Text
                                            Container(
                                              height: scaler.getWidth(5),
                                              margin: EdgeInsets.only(
                                                  top: scaler.getWidth(1),
                                                  bottom: scaler.getWidth(.5)),
                                              child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: RichText(
                                                      text: TextSpan(
                                                    text: "City",
                                                    style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        color: Colors.black),
                                                  ))),
                                            ),
                                            // City TextField
                                            Container(
                                              width: scaler.getWidth(35),
                                              height: scaler.getWidth(10),
                                              child: TextFormField(
                                                onSaved: (input) {
                                                  city = input;
                                                },
                                                initialValue: city,
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
                                        SizedBox(
                                          width: scaler.getWidth(5),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            //State Text
                                            Container(
                                              height: scaler.getWidth(5),
                                              margin: EdgeInsets.only(
                                                  top: scaler.getWidth(1),
                                                  bottom: scaler.getWidth(.5)),
                                              child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: RichText(
                                                      text: TextSpan(
                                                    text: "State",
                                                    style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        color: Colors.black),
                                                  ))),
                                            ),
                                            // State TextField
                                            Container(
                                              width: scaler.getWidth(35),
                                              height: scaler.getWidth(10),
                                              child: TextFormField(
                                                onSaved: (input) {
                                                  state = input;
                                                },
                                                initialValue: state,
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
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: scaler.getWidth(1),
                                    ),
                                    //Row 9 Postcode
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //Post Code Text
                                        Container(
                                          height: scaler.getWidth(5),
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: RichText(
                                                  text: TextSpan(
                                                text: "Postcode",
                                                style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    color: Colors.black),
                                              ))),
                                        ),
                                        // Postcode TextField
                                        Container(
                                          width: scaler.getWidth(35),
                                          height: scaler.getWidth(10),
                                          child: TextFormField(
                                            onSaved: (input) {
                                              postcode = input;
                                            },
                                            initialValue: postcode,
                                            style: GoogleFonts.lato(
                                                textStyle:
                                                    TextStyle(fontSize: 16)),
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
                                                      fontSize: 16, height: 0)),
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
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: scaler.getWidth(1),
                                    ),
                                    //Row 10 Country
                                    Row(
                                      children: <Widget>[
                                        // Country Code Container
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                                FontWeight
                                                                    .bold),
                                                        color: Colors.black),
                                                  ))),
                                            ),
                                            // Country Code Field
                                            Container(
                                                padding: EdgeInsets.only(
                                                    right:
                                                        scaler.getHeight(.5)),
                                                alignment:
                                                    Alignment.centerRight,
                                                height: scaler.getHeight(5),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Color(0xff6747CD),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Container(
                                                  width: scaler.getWidth(80),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      SizedBox(width: 8.0),
                                                      CountryPickerUtils
                                                          .getDefaultFlagImage(
                                                              countryF),
                                                      SizedBox(width: 8.0),
                                                      Container(
                                                          width: scaler
                                                              .getWidth(60),
                                                          child: Text(
                                                            countryF.name,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: GoogleFonts.lato(
                                                                textStyle: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          )),
                                                      Expanded(
                                                          child: SizedBox(
                                                              width: 8.0)),
                                                      GestureDetector(
                                                        onTap:
                                                            _openCountryPickerDialogF,
                                                        child: Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                          color:
                                                              Color(0xff6747CD),
                                                        ),
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
                                  height: scaler.getWidth(1),
                                ), //Padding
                              ],
                            ),
                          ),
                          ArrowButtom(
                            onTap: () async {
                              await registerWorkExperience();
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

  bool validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  Future<Null> _selectToDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: toDate,
        firstDate: DateTime(1960, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != toDate) {
      setState(() {
        toDate = picked;
        print("${toDate.toLocal()}".split(' ')[0]);
      });
    }
  }

  Future<Null> _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(1960, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
        print("${startDate.toLocal()}".split(' ')[0]);
      });
    }
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
  void _openCountryPickerDialogF() => showDialog(
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
                setState(() => countryFirst = country.name),
            itemBuilder: _buildDialogItem,
          ),
        ),
      );

  Future<void> registerWorkExperience() async {
    {
      final formState = _formKey.currentState;
      widget.userBloc = BlocProvider.of(context);
      if (formState.validate()) {
        formState.save();
        try {
          if (employersName != null && positionHeld != null) {
            widget.userBloc.registerWorkExperience(
                widget.userId,
                employersName,
                positionHeld,
                dropdownIsEmployer,
                email,
                "${startDate.toLocal()}".split(' ')[0],
                "${toDate.toLocal()}".split(' ')[0],
                residential,
                city,
                state,
                postcode,
                countryFirst);
          }
          print('Success');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SupportingDocumentsPage(
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
