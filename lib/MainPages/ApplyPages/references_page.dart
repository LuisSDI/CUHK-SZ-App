import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';
import 'package:cuhkszapp/resources/arrow_button.dart';
import "package:flutter/material.dart";
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class ReferencesPage extends StatefulWidget {
  UserBloc userBloc;
  final String userId;
  final GlobalKey<State> keyLoader = new GlobalKey<State>();

  ReferencesPage({Key key, this.userId}) : super(key: key);

  @override
  _ReferencesPageState createState() => _ReferencesPageState();
}

class _ReferencesPageState extends State<ReferencesPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> scaffkey = GlobalKey();
  DateTime birthDate;
  DateTime expireDate;
  String dropdownTitleFirst;
  String givenNameFirst;
  String familyNameFirst;
  String organizationFirst;
  String jobFirst;
  String emailFirst;
  String phoneFirst;
  String residentialFirst;
  String cityFirst;
  String stateFirst;
  String postcodeFirst;
  String countryFirst;
  String dropdownTitleSecond;
  String givenNameSecond;
  String familyNameSecond;
  String organizationSecond;
  String jobSecond;
  String emailSecond;
  String phoneSecond;
  String residentialSecond;
  String citySecond;
  String stateSecond;
  String postcodeSecond;
  String countrySecond;
  String dropdownGender;
  String placeBirth;
  String passportNum;
  String placeIssue;
  String religion;
  GlobalKey<ScaffoldState> _scaffkey = GlobalKey();

  Stream<DocumentSnapshot> _stream;

  @override
  void initState() {
    // Only create the stream once
    _stream = UserBloc().getPersonalDetails(widget.userId);
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
                Map personalDetails = snapshot.data.data;
                if (personalDetails != null) {
                  dropdownTitleFirst ??= personalDetails['title'];
                  givenNameFirst = personalDetails['given name'];
                  familyNameFirst = personalDetails['family name'];
                  dropdownGender ??= personalDetails['gender'];
                  birthDate ??=
                      DateTime.parse(personalDetails['date of birth']);
                  expireDate ??=
                      DateTime.parse(personalDetails['date of expire']);
                  //countryField ??= personalDetails['nationality'];
                  passportNum = personalDetails['passport'];
                  placeIssue = personalDetails['place of issue'];
                  religion = personalDetails['religion'];
                  placeBirth = personalDetails['place of birth'];
                }
              }
              ScreenScaler scaler = ScreenScaler()..init(context);
              dropdownGender ??= 'Male';
              dropdownTitleFirst ??= 'Mr';
              Country countryF;
              if (countryFirst != null) {
                countryF = CountryPickerUtils.getCountryByName(countryFirst);
              } else {
                countryF = CountryPickerUtils.getCountryByName('China');
              }

              dropdownTitleSecond ??= 'Mr';
              Country countryS;
              if (countrySecond != null) {
                countryS = CountryPickerUtils.getCountryByName(countryFirst);
              } else {
                countryS = CountryPickerUtils.getCountryByName('China');
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
                                          "6. References",
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
                                    """Please submit your two referees that are required who need to be your teaching faculties"""
                                        .trim(),
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff62626C))),
                                  ),
                                ),
                                //Referre Form
                                Container(
                                  margin: EdgeInsets.only(
                                      top: scaler.getWidth(1),
                                      bottom: scaler.getWidth(.5)),
                                  child: RichText(
                                      text: TextSpan(
                                    text: '''First Referee''',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                        color: Colors.black),
                                  )),
                                ),
                                //Row 1 of TextField
                                Row(
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // Title* Text
                                        Container(
                                          height: scaler.getWidth(5),
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: "Title",
                                                      style: GoogleFonts.lato(
                                                          textStyle: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                  ]))),
                                        ),

                                        // Title Field
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
                                            value: dropdownTitleFirst,
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color(0xff6747CD),
                                            ),
                                            iconSize: 24,
                                            elevation: 16,
                                            onChanged: (String newValue) {
                                              setState(() {
                                                print(newValue);
                                                dropdownTitleFirst = newValue;
                                              });
                                            },
                                            items: <String>[
                                              'Mr',
                                              'Mrs',
                                              'Ms',
                                              'Miss',
                                              'Dr',
                                              'Prof'
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
                                    SizedBox(
                                      width: scaler.getWidth(5),
                                    ),
                                  ],
                                ),
                                //Padding
                                SizedBox(
                                  height: scaler.getWidth(1),
                                ),
                                //Row 2 of TextField
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //Given Name Text
                                        Container(
                                          height: scaler.getWidth(5),
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: "Given Name",
                                                      style: GoogleFonts.lato(
                                                          textStyle: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                  ]))),
                                        ),
                                        // Given Name TextField
                                        Container(
                                          width: scaler.getHeight(18),
                                          height: scaler.getWidth(10),
                                          child: TextFormField(
                                            validator: (input) {
                                              if (input.isEmpty) {
                                                return '';
                                              }
                                            },
                                            onSaved: (input) {
                                              givenNameFirst = input;
                                            },
                                            initialValue: givenNameFirst,
                                            maxLength: 15,
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
                                      width: scaler.getWidth(5),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //Family Name Text
                                        Container(
                                          height: scaler.getWidth(5),
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: "Family Name",
                                                      style: GoogleFonts.lato(
                                                          textStyle: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                  ]))),
                                        ),
                                        // Family Name TextField
                                        Container(
                                          width: scaler.getHeight(20),
                                          height: scaler.getWidth(10),
                                          child: TextFormField(
                                            validator: (input) {
                                              if (input.isEmpty) {
                                                return '';
                                              }
                                            },
                                            onSaved: (input) {
                                              familyNameFirst = input;
                                            },
                                            initialValue: familyNameFirst,
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
                                  ],
                                ),
                                //Padding
                                SizedBox(
                                  height: scaler.getWidth(1),
                                ),
                                //Row 3 Organization Name
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    //Organization Text
                                    Container(
                                      height: scaler.getWidth(5),
                                      margin: EdgeInsets.only(
                                          top: scaler.getWidth(1),
                                          bottom: scaler.getWidth(.5)),
                                      child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: RichText(
                                              text: TextSpan(
                                                  text: "Organization Name",
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
                                              ]))),
                                    ),
                                    // Organization TextField
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
                                          organizationFirst = input;
                                        },
                                        initialValue: organizationFirst,
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
                                //Row 4 Job Title
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    //Job Title Text
                                    Container(
                                      height: scaler.getWidth(5),
                                      margin: EdgeInsets.only(
                                          top: scaler.getWidth(1),
                                          bottom: scaler.getWidth(.5)),
                                      child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: RichText(
                                              text: TextSpan(
                                                  text: "Job Title",
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
                                              ]))),
                                    ),
                                    // Job TextField
                                    Container(
                                      width: scaler.getHeight(18),
                                      height: scaler.getWidth(10),
                                      child: TextFormField(
                                        validator: (input) {
                                          if (input.isEmpty) {
                                            return '';
                                          }
                                        },
                                        onSaved: (input) {
                                          jobFirst = input;
                                        },
                                        initialValue: jobFirst,
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
                                                                  FontWeight
                                                                      .bold),
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
                                                  ]))),
                                        ),
                                        // Email TextField
                                        Container(
                                          width: scaler.getWidth(80),
                                          height: scaler.getWidth(10),
                                          child: TextFormField(
                                            validator: (input) {
                                              if (!validateEmail(input)) {
                                                _scaffkey.currentState
                                                    .showSnackBar(SnackBar(
                                                  duration:
                                                      Duration(seconds: 1),
                                                  content: Container(
                                                    alignment: Alignment.center,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.05,
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
                                              emailFirst = input;
                                            },
                                            initialValue: emailFirst,
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
                                //Row 6 Phone
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    //Phone Text
                                    Container(
                                      height: scaler.getWidth(5),
                                      margin: EdgeInsets.only(
                                          top: scaler.getWidth(1),
                                          bottom: scaler.getWidth(.5)),
                                      child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: RichText(
                                              text: TextSpan(
                                                  text: "Phone",
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
                                              ]))),
                                    ),
                                    // Phone TextField
                                    Container(
                                      width: scaler.getWidth(50),
                                      height: scaler.getWidth(10),
                                      child: TextFormField(
                                        validator: (input) {
                                          if (input.trim().length < 10) {
                                            _scaffkey.currentState
                                                .showSnackBar(SnackBar(
                                              duration: Duration(seconds: 1),
                                              content: Container(
                                                alignment: Alignment.center,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                child: Text(
                                                  "Please enter a valid phone number",
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
                                          phoneFirst = input;
                                        },
                                        initialValue: phoneFirst,
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
                                    // Note Text
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: scaler.getWidth(1),
                                          bottom: scaler.getWidth(1),
                                          right: scaler.getHeight(.5),
                                          left: scaler.getHeight(0)),
                                      child: Text(
                                        '''Please include international prefix and area code in the format. For example for China '0086-755-8427-1000\''''
                                            .trim(),
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff6747CD))),
                                      ),
                                    ),
                                  ],
                                ),
                                //Padding
                                SizedBox(
                                  height: scaler.getWidth(1),
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
                                                  residentialFirst = input;
                                                },
                                                initialValue: residentialFirst,
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
                                                  cityFirst = input;
                                                },
                                                initialValue: cityFirst,
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
                                                  stateFirst = input;
                                                },
                                                initialValue: stateFirst,
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
                                              postcodeFirst = input;
                                            },
                                            initialValue: postcodeFirst,
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
                                //Referre Form
                                Container(
                                  margin: EdgeInsets.only(
                                      top: scaler.getWidth(1),
                                      bottom: scaler.getWidth(.5)),
                                  child: RichText(
                                      text: TextSpan(
                                    text: '''Second Referee''',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                        color: Colors.black),
                                  )),
                                ),
                                //Row 1 of TextField
                                Row(
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // Title* Text
                                        Container(
                                          height: scaler.getWidth(5),
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: "Title",
                                                      style: GoogleFonts.lato(
                                                          textStyle: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                  ]))),
                                        ),

                                        // Title Field
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
                                            value: dropdownTitleSecond,
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color(0xff6747CD),
                                            ),
                                            iconSize: 24,
                                            elevation: 16,
                                            onChanged: (String newValue) {
                                              setState(() {
                                                print(newValue);
                                                dropdownTitleSecond = newValue;
                                              });
                                            },
                                            items: <String>[
                                              'Mr',
                                              'Mrs',
                                              'Ms',
                                              'Miss',
                                              'Dr',
                                              'Prof'
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
                                    SizedBox(
                                      width: scaler.getWidth(5),
                                    ),
                                  ],
                                ),
                                //Padding
                                SizedBox(
                                  height: scaler.getWidth(1),
                                ),
                                //Row 2 of TextField
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //Given Name Text
                                        Container(
                                          height: scaler.getWidth(5),
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: "Given Name",
                                                      style: GoogleFonts.lato(
                                                          textStyle: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                  ]))),
                                        ),
                                        // Given Name TextField
                                        Container(
                                          width: scaler.getHeight(18),
                                          height: scaler.getWidth(10),
                                          child: TextFormField(
                                            validator: (input) {
                                              if (input.isEmpty) {
                                                return '';
                                              }
                                            },
                                            onSaved: (input) {
                                              givenNameSecond = input;
                                            },
                                            initialValue: givenNameSecond,
                                            maxLength: 15,
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
                                      width: scaler.getWidth(5),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //Family Name Text
                                        Container(
                                          height: scaler.getWidth(5),
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: "Family Name",
                                                      style: GoogleFonts.lato(
                                                          textStyle: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                  ]))),
                                        ),
                                        // Family Name TextField
                                        Container(
                                          width: scaler.getHeight(20),
                                          height: scaler.getWidth(10),
                                          child: TextFormField(
                                            validator: (input) {
                                              if (input.isEmpty) {
                                                return '';
                                              }
                                            },
                                            onSaved: (input) {
                                              familyNameSecond = input;
                                            },
                                            initialValue: familyNameSecond,
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
                                  ],
                                ),
                                //Padding
                                SizedBox(
                                  height: scaler.getWidth(1),
                                ),
                                //Row 3 Organization Name
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    //Organization Text
                                    Container(
                                      height: scaler.getWidth(5),
                                      margin: EdgeInsets.only(
                                          top: scaler.getWidth(1),
                                          bottom: scaler.getWidth(.5)),
                                      child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: RichText(
                                              text: TextSpan(
                                                  text: "Organization Name",
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
                                              ]))),
                                    ),
                                    // Organization TextField
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
                                          organizationSecond = input;
                                        },
                                        initialValue: organizationSecond,
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
                                //Row 4 Job Title
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    //Job Title Text
                                    Container(
                                      height: scaler.getWidth(5),
                                      margin: EdgeInsets.only(
                                          top: scaler.getWidth(1),
                                          bottom: scaler.getWidth(.5)),
                                      child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: RichText(
                                              text: TextSpan(
                                                  text: "Job Title",
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
                                              ]))),
                                    ),
                                    // Job TextField
                                    Container(
                                      width: scaler.getHeight(18),
                                      height: scaler.getWidth(10),
                                      child: TextFormField(
                                        validator: (input) {
                                          if (input.isEmpty) {
                                            return '';
                                          }
                                        },
                                        onSaved: (input) {
                                          jobSecond = input;
                                        },
                                        initialValue: jobSecond,
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
                                                                  FontWeight
                                                                      .bold),
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
                                                  ]))),
                                        ),
                                        // Email TextField
                                        Container(
                                          width: scaler.getWidth(80),
                                          height: scaler.getWidth(10),
                                          child: TextFormField(
                                            validator: (input) {
                                              if (!validateEmail(input)) {
                                                _scaffkey.currentState
                                                    .showSnackBar(SnackBar(
                                                  duration:
                                                      Duration(seconds: 1),
                                                  content: Container(
                                                    alignment: Alignment.center,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.05,
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
                                              emailSecond = input;
                                            },
                                            initialValue: emailSecond,
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
                                //Row 6 Phone
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    //Phone Text
                                    Container(
                                      height: scaler.getWidth(5),
                                      margin: EdgeInsets.only(
                                          top: scaler.getWidth(1),
                                          bottom: scaler.getWidth(.5)),
                                      child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: RichText(
                                              text: TextSpan(
                                                  text: "Phone",
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
                                              ]))),
                                    ),
                                    // Phone TextField
                                    Container(
                                      width: scaler.getWidth(50),
                                      height: scaler.getWidth(10),
                                      child: TextFormField(
                                        validator: (input) {
                                          if (input.trim().length < 10) {
                                            _scaffkey.currentState
                                                .showSnackBar(SnackBar(
                                              duration: Duration(seconds: 1),
                                              content: Container(
                                                alignment: Alignment.center,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                child: Text(
                                                  "Please enter a valid phone number",
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
                                          phoneSecond = input;
                                        },
                                        initialValue: phoneSecond,
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
                                    // Note Text
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: scaler.getWidth(1),
                                          bottom: scaler.getWidth(1),
                                          right: scaler.getHeight(.5),
                                          left: scaler.getHeight(0)),
                                      child: Text(
                                        '''Please include international prefix and area code in the format. For example for China '0086-755-8427-1000\''''
                                            .trim(),
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff6747CD))),
                                      ),
                                    ),
                                  ],
                                ),
                                //Padding
                                SizedBox(
                                  height: scaler.getWidth(1),
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
                                                  residentialSecond = input;
                                                },
                                                initialValue: residentialSecond,
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
                                                  citySecond = input;
                                                },
                                                initialValue: citySecond,
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
                                                  stateSecond = input;
                                                },
                                                initialValue: stateSecond,
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
                                              postcodeSecond = input;
                                            },
                                            initialValue: postcodeSecond,
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
                                                              countryS),
                                                      SizedBox(width: 8.0),
                                                      Container(
                                                          width: scaler
                                                              .getWidth(60),
                                                          child: Text(
                                                            countryS.name,
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
                                                            _openCountryPickerDialogS,
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
                              await registerPersonalDetails();
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

  void _openCountryPickerDialogS() => showDialog(
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
                setState(() => countrySecond = country.name),
            itemBuilder: _buildDialogItem,
          ),
        ),
      );

  bool validatePassport(String value) {
    String pattern = r'^(?!^0+$)[a-zA-Z0-9]{3,20}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  Future<Null> _selectBirth(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: birthDate,
        firstDate: DateTime(1960, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != birthDate) {
      setState(() {
        birthDate = picked;
        print("${birthDate.toLocal()}".split(' ')[0]);
      });
    }
  }

  Future<Null> _selectExpire(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: expireDate,
        firstDate: DateTime(1960, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != expireDate) {
      setState(() {
        expireDate = picked;
        print("${expireDate.toLocal()}".split(' ')[0]);
      });
    }
  }

  Future<void> registerPersonalDetails() async {
    {
      final formState = _formKey.currentState;
      widget.userBloc = BlocProvider.of(context);
      if (formState.validate()) {
        formState.save();
        try {
          // widget.userBloc.registerPersonalDetails(
          //     widget.userId,
          //     dropdownTitleFirst,
          //     givenNameFirst,
          //     middleName,
          //     familyNameFirst,
          //     dropdownGender,
          //     "${birthDate.toLocal()}".split(' ')[0],
          //     placeBirth,
          //     countryField,
          //     passportNum,
          //     "${expireDate.toLocal()}".split(' ')[0],
          //     placeIssue,
          //     religion);

          // // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => ContactDetailsPage(
          //           userId: widget.userId,
          //         )));

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
              "Please dont leave any required field empty",
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
