import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';
import 'package:cuhkszapp/resources/arrow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'contact_details_page.dart';

class PersonalDetailsPage extends StatefulWidget {
  @override
  UserBloc userBloc;
  final String userId;
  final GlobalKey<State> keyLoader = new GlobalKey<State>();

  PersonalDetailsPage({Key key, @required this.userId}) : super(key: key);

  _PersonalDetailsPageState createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String dropdownTitle;
  String givenName, middleName;
  GlobalKey<ScaffoldState> scaffkey = GlobalKey();
  DateTime birthDate;
  DateTime expireDate;
  String familyName;
  String dropdownGender;
  String placeBirth;
  String passportNum;
  String placeIssue;
  String religion;
  GlobalKey<ScaffoldState> _scaffkey = GlobalKey();
  String countryField;

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
          builder: (context,  snapshot) {
            if (snapshot.connectionState == ConnectionState.active){
              if(snapshot.hasData){
                Map personalDetails = snapshot.data.data;
                if (personalDetails != null) {
                  dropdownTitle ??= personalDetails['title'];
                  givenName = personalDetails['given name'];
                  middleName = personalDetails['middle name'];
                  familyName = personalDetails['family name'];
                  dropdownGender ??= personalDetails['gender'];
                  birthDate ??= DateTime.parse(personalDetails['date of birth']);
                  expireDate ??= DateTime.parse(personalDetails['date of expire']);
                  countryField ??= personalDetails['nationality'];
                  passportNum = personalDetails['passport'];
                  placeIssue = personalDetails['place of issue'];
                  religion = personalDetails['religion'];
                  placeBirth = personalDetails['place of birth'];
                }

              }
              ScreenScaler scaler = ScreenScaler()..init(context);
              dropdownGender ??= 'Male';
              dropdownTitle ??= 'Mr';
              birthDate ??= DateTime.now();
              expireDate ??= DateTime.now();
              countryField ??= 'China';
              Country country = CountryPickerUtils.getCountryByName(countryField);
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
                                              "1.1 Personal Details",
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
                                        """Please complete this form in English and enter your name exactly as it appears on your passport, as this will be used for your offer letter and visa."""
                                            .trim(),
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 16, color: Color(0xff62626C))),
                                      ),
                                    ),
                                    //Row 1 of TextField
                                    Row(
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                                value: dropdownTitle,
                                                icon: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Color(0xff6747CD),
                                                ),
                                                iconSize: 24,
                                                elevation: 16,
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    print(newValue);
                                                    dropdownTitle = newValue;
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
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                            // Given Name TextField
                                            Container(
                                              width: scaler.getWidth(40),
                                              height: scaler.getWidth(10),
                                              child: TextFormField(
                                                validator: (input) {
                                                  if (input.isEmpty) {
                                                    return '';
                                                  }
                                                },
                                                onSaved: (input) {
                                                  givenName = input;
                                                },
                                                initialValue: givenName,
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
                                    //Row 2 of TextField
                                    Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            //Middle Name Text
                                            Container(
                                              height: scaler.getWidth(5),
                                              margin: EdgeInsets.only(
                                                  top: scaler.getWidth(1),
                                                  bottom: scaler.getWidth(.5)),
                                              child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: RichText(
                                                      text: TextSpan(
                                                        text: "Middle Name",
                                                        style: GoogleFonts.lato(
                                                            textStyle: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold),
                                                            color: Colors.black),
                                                      ))),
                                            ),
                                            // Middle Name TextField
                                            Container(
                                              width: scaler.getWidth(30),
                                              height: scaler.getWidth(10),
                                              child: TextFormField(
                                                onSaved: (input) {
                                                  middleName = input;
                                                },
                                                maxLength: 15,
                                                initialValue: middleName,
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
                                        SizedBox(
                                          width: scaler.getWidth(5),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                            // Family Name TextField
                                            Container(
                                              width: scaler.getWidth(40),
                                              height: scaler.getWidth(10),
                                              child: TextFormField(
                                                validator: (input) {
                                                  if (input.isEmpty) {
                                                    return '';
                                                  }
                                                },
                                                onSaved: (input) {
                                                  familyName = input;
                                                },
                                                initialValue: familyName,
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
                                      ],
                                    ),
                                    //Padding
                                    SizedBox(
                                      height: scaler.getWidth(1),
                                    ),
                                    //Row 3 Gender
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // Gender Text
                                        Container(
                                          height: scaler.getWidth(5),
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: "Gender",
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

                                        // Gender Field
                                        Container(
                                          width: scaler.getWidth(25),
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
                                            value: dropdownGender,
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color(0xff6747CD),
                                            ),
                                            iconSize: 24,
                                            elevation: 16,
                                            onChanged: (String newValue) {
                                              setState(() {
                                                print(newValue);
                                                dropdownGender = newValue;
                                              });
                                            },
                                            items: <String>[
                                              'Male',
                                              'Female',
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
                                    //Padding
                                    SizedBox(
                                      height: scaler.getWidth(1),
                                    ),
                                    //Row 4 Birth
                                    Row(
                                      children: <Widget>[
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
                                                          text: "Date of Birth",
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

                                            // Date Field
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
                                                            "${birthDate.toLocal()}".split(' ')[0],
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
                                                        onTap:() => _selectBirth(context),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          width: scaler.getWidth(5),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            //Place of Birth Text
                                            Container(
                                              height: scaler.getWidth(5),
                                              margin: EdgeInsets.only(
                                                  top: scaler.getWidth(1),
                                                  bottom: scaler.getWidth(.5)),
                                              child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: RichText(
                                                      text: TextSpan(
                                                          text: "Place of Birth",
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
                                            // Family Name TextField
                                            Container(
                                              width: scaler.getWidth(40),
                                              height: scaler.getWidth(10),
                                              child: TextFormField(
                                                validator: (input) {
                                                  if (input.isEmpty) {
                                                    return '';
                                                  }
                                                },
                                                onSaved: (input) {
                                                  placeBirth = input;
                                                },
                                                initialValue: placeBirth,
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
                                      ],
                                    ),
                                    //Padding
                                    SizedBox(
                                      height: scaler.getWidth(1),
                                    ),
                                    //Row 5 Nationality Container
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
                                                          text: "Nationality",
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
                                            // Country Code Field
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
                                                          .getDefaultFlagImage(country),
                                                      SizedBox(width: 8.0),
                                                      Container(
                                                          width: scaler.getWidth(60),
                                                          child: Text(
                                                            country.name,
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
                                    //Padding
                                    SizedBox(
                                      height: scaler.getWidth(1),
                                    ),
                                    //Row 6 Passport
                                    Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            //Passport Number Text
                                            Container(
                                              height: scaler.getWidth(5),
                                              margin: EdgeInsets.only(
                                                  top: scaler.getWidth(1),
                                                  bottom: scaler.getWidth(.5)),
                                              child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: RichText(
                                                      text: TextSpan(
                                                          text: "Passport No.",
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
                                            // Passport No TextField
                                            Container(
                                              width: scaler.getWidth(30),
                                              height: scaler.getWidth(10),
                                              child: TextFormField(
                                                validator: (input) {
                                                  if (!validatePassport(input)) {
                                                    _scaffkey.currentState.showSnackBar(SnackBar(
                                                      duration: Duration(seconds: 1),
                                                      content: Container(
                                                        alignment: Alignment.center,
                                                        height: MediaQuery.of(context).size.height * 0.05,
                                                        child: Text(
                                                          "Please enter a valid passport number",
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
                                                  passportNum = input;
                                                },
                                                initialValue: passportNum,
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
                                        SizedBox(
                                          width: scaler.getWidth(5),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            // Date of Expire Text
                                            Container(
                                              height: scaler.getWidth(5),
                                              margin: EdgeInsets.only(
                                                  top: scaler.getWidth(1),
                                                  bottom: scaler.getWidth(.5)),
                                              child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: RichText(
                                                      text: TextSpan(
                                                          text: "Date of Expire",
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

                                            // Date Field
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
                                                            "${expireDate.toLocal()}".split(' ')[0],
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
                                                        onTap:() => _selectExpire(context),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),

                                      ],
                                    ),
                                    //Padding
                                    SizedBox(
                                      height: scaler.getWidth(1),
                                    ),
                                    //Row 7 of TextField
                                    Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            //Place of Issue (City) Text
                                            Container(
                                              height: scaler.getWidth(5),
                                              margin: EdgeInsets.only(
                                                  top: scaler.getWidth(1),
                                                  bottom: scaler.getWidth(.5)),
                                              child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: RichText(
                                                      text: TextSpan(
                                                          text: "Place of Issue (City)",
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
                                            // Place of Issue TextField
                                            Container(
                                              width: scaler.getWidth(40),
                                              height: scaler.getWidth(10),
                                              child: TextFormField(
                                                validator: (input) {
                                                  if (input.isEmpty) {
                                                    return '';
                                                  }
                                                },
                                                onSaved: (input) {
                                                  placeIssue = input;
                                                },
                                                maxLength: 25,
                                                initialValue: placeIssue,
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
                                        SizedBox(
                                          width: scaler.getWidth(5),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            //Religion Text
                                            Container(
                                              height: scaler.getWidth(5),
                                              margin: EdgeInsets.only(
                                                  top: scaler.getWidth(1),
                                                  bottom: scaler.getWidth(.5)),
                                              child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: RichText(
                                                      text: TextSpan(
                                                        text: "Religion",
                                                        style: GoogleFonts.lato(
                                                            textStyle: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold),
                                                            color: Colors.black),
                                                      ))),
                                            ),
                                            // Religion TextField
                                            Container(
                                              width: scaler.getWidth(30),
                                              height: scaler.getWidth(10),
                                              child: TextFormField(
                                                onSaved: (input) {
                                                  religion = input;
                                                },
                                                initialValue: religion,
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

                                      ],
                                    ),
                                    //Padding
                                    SizedBox(
                                      height: scaler.getWidth(4),
                                    ),
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
                setState(() => countryField = country.name),
            itemBuilder: _buildDialogItem,
          ),
        ),
      );

  bool validatePassport(String value){
    String  pattern = r'^(?!^0+$)[a-zA-Z0-9]{3,20}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }


  Future<Null> _selectBirth(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: birthDate,
        firstDate: DateTime(1960, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != birthDate){
      setState(() {
        birthDate = picked;
        print("${birthDate.toLocal()}".split(' ')[0]);
      });}
  }

  Future<Null> _selectExpire(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: expireDate,
        firstDate: DateTime(1960, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != expireDate){
      
      setState(() {
        expireDate = picked;
        print("${expireDate.toLocal()}".split(' ')[0]);
      });}
  }


  Future<void> registerPersonalDetails() async {
    {
      final formState = _formKey.currentState;
      widget.userBloc = BlocProvider.of(context);
      if (formState.validate()) {
        formState.save();
        try {
          widget.userBloc.registerPersonalDetails(widget.userId, dropdownTitle, givenName, middleName, familyName,
              dropdownGender, "${birthDate.toLocal()}".split(' ')[0], placeBirth, countryField, passportNum, "${expireDate.toLocal()}".split(' ')[0], placeIssue, religion);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ContactDetailsPage(
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
