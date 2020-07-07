import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';
import 'package:cuhkszapp/resources/arrow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactDetailsPage extends StatefulWidget {

  UserBloc userBloc;
  final String userId;

  ContactDetailsPage({Key key, this.userId}) : super(key: key);

  @override
  _ContactDetailsPageState createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email;
  GlobalKey<ScaffoldState> _scaffkey = GlobalKey();
  String countryResident;
  String otherEmail;
  String phoneNum;
  String mobileNum;
  String residentialAddress;
  String cityResident;
  String stateResident;
  String postcodeResident;
  String postalAddress;
  String cityPostal;
  String statePostal;
  String postcodePostal;
  String countryPostal;
  String emergencyContact;
  String emergencyRel;
  String mobileInt;

  Stream<DocumentSnapshot> _stream;

  @override
  void initState() {
    // Only create the stream once
    _stream = UserBloc().getContactDetails(widget.userId);
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
                print(snapshot.data.data);
                Map contactDetails = snapshot.data.data;
                email = contactDetails['email'];
                otherEmail = contactDetails['other email'];
                countryResident ??= contactDetails['residential country'];
                phoneNum = contactDetails['phone'];
                mobileNum = contactDetails['mobile'];
                residentialAddress = contactDetails['residential address'];
                cityResident = contactDetails['residential city'];
                stateResident = contactDetails['residential state'];
                postcodeResident = contactDetails['residential postcode'];
                postalAddress = contactDetails['postal address'];
                cityPostal = contactDetails['postal city'];
                statePostal= contactDetails['postal state'];
                postcodePostal = contactDetails['postal postcode'];
                countryPostal ??= contactDetails['postal country'];
                emergencyContact = contactDetails['emergency contact name'];
                emergencyRel = contactDetails['emergency relationship'];
                mobileInt = contactDetails['mobile for interview'];
              }
              ScreenScaler scaler = ScreenScaler()..init(context);
              countryResident ??= 'China';
              countryPostal ??= 'China';
              Country countryR = CountryPickerUtils.getCountryByName(countryResident);
              Country countryP = CountryPickerUtils.getCountryByName(countryPostal);
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
                                              "1.2 Contact Details",
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
''' Please note: Your Postal Address will be the address where you will receive any mailed documentation, including your visa and offer letter package.'''.trim(),
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 16, color: Color(0xff62626C))),
                                      ),
                                    ),
                                    //Row 1 of TextField
                                    Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  email = input;
                                                },
                                                initialValue: email,
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
                                            //Other Email Text
                                            Container(
                                              height: scaler.getWidth(5),
                                              margin: EdgeInsets.only(
                                                  top: scaler.getWidth(1),
                                                  bottom: scaler.getWidth(.5)),
                                              child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: RichText(
                                                      text: TextSpan(
                                                          text: "Other Email",
                                                          style: GoogleFonts.lato(
                                                              textStyle: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                  FontWeight.bold),
                                                              color: Colors.black),
                                                          ))),
                                            ),
                                            // Other Email TextField
                                            Container(
                                              width: scaler.getWidth(80),
                                              height: scaler.getWidth(10),
                                              child: TextFormField(
                                                onSaved: (input) {
                                                  otherEmail = input;
                                                },
                                                initialValue: otherEmail,
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
                                    //Row 3 Phone
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
                                                                  color:
                                                                  Color(0xff6747CD))),
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
                                                _scaffkey.currentState.showSnackBar(SnackBar(
                                                  duration: Duration(seconds: 1),
                                                  content: Container(
                                                    alignment: Alignment.center,
                                                    height: MediaQuery.of(context).size.height * 0.05,
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
                                              phoneNum = input;
                                            },
                                            initialValue: phoneNum,
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
                                        // Note Text
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(1),
                                              right: scaler.getHeight(.5),
                                              left: scaler.getHeight(0)),
                                          child: Text(
                                            '''Please include international prefix and area code in the format. For example for China '0086-755-8427-1000\''''.trim(),
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 14, color: Color(0xff6747CD))),
                                          ),
                                        ),
                                      ],
                                    ),
                                    //Padding
                                    SizedBox(
                                      height: scaler.getWidth(1),
                                    ),
                                    //Row 4 Mobile
                                    Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            //Mobile Text
                                            Container(
                                              height: scaler.getWidth(5),
                                              margin: EdgeInsets.only(
                                                  top: scaler.getWidth(1),
                                                  bottom: scaler.getWidth(.5)),
                                              child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: RichText(
                                                      text: TextSpan(
                                                          text: "Mobile",
                                                          style: GoogleFonts.lato(
                                                              textStyle: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                  FontWeight.bold),
                                                              color: Colors.black),
                                                          ))),
                                            ),
                                            // Mobile TextField
                                            Container(
                                              width: scaler.getWidth(50),
                                              height: scaler.getWidth(10),
                                              child: TextFormField(
                                                onSaved: (input) {
                                                  mobileNum = input;
                                                },
                                                initialValue: mobileNum,
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
                                      ],
                                    ),
                                    //Padding
                                    SizedBox(
                                      height: scaler.getWidth(1),
                                    ),
                                    //Residential Address
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                //Residential Address Text
                                                Container(
                                                  height: scaler.getWidth(5),
                                                  margin: EdgeInsets.only(
                                                      top: scaler.getWidth(1),
                                                      bottom: scaler.getWidth(.5)),
                                                  child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: RichText(
                                                          text: TextSpan(
                                                              text: "Residential Address in Home Country",
                                                              style: GoogleFonts.lato(
                                                                  textStyle: TextStyle(
                                                                      fontSize: 17.5,
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
                                                // Residential Address TextField
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
                                                      residentialAddress = input;
                                                    },
                                                    initialValue: residentialAddress,
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
                                        SizedBox(
                                          height: scaler.getWidth(1),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                // City TextField
                                                Container(
                                                  width: scaler.getWidth(35),
                                                  height: scaler.getWidth(10),
                                                  child: TextFormField(
                                                    validator: (input) {
                                                      if (input.isEmpty) {
                                                        return '';
                                                      }
                                                    },
                                                    onSaved: (input) {
                                                      cityResident = input;
                                                    },
                                                    initialValue: cityResident,
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
                                                // City TextField
                                                Container(
                                                  width: scaler.getWidth(35),
                                                  height: scaler.getWidth(10),
                                                  child: TextFormField(
                                                    validator: (input) {
                                                      if (input.isEmpty) {
                                                        return '';
                                                      }
                                                    },
                                                    onSaved: (input) {
                                                      stateResident = input;
                                                    },
                                                    initialValue: stateResident,
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
                                        SizedBox(
                                          height: scaler.getWidth(1),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                            // Postcode TextField
                                            Container(
                                              width: scaler.getWidth(35),
                                              height: scaler.getWidth(10),
                                              child: TextFormField(
                                                validator: (input) {
                                                  if (input.isEmpty) {
                                                    return '';
                                                  }
                                                },
                                                onSaved: (input) {
                                                  postcodeResident = input;
                                                },
                                                initialValue: postcodeResident,
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
                                          height: scaler.getWidth(1),
                                        ),
                                        //Country Container
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
                                                              .getDefaultFlagImage(countryR),
                                                          SizedBox(width: 8.0),
                                                          Container(
                                                              width: scaler.getWidth(60),
                                                              child: Text(
                                                                countryR.name,
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

                                      ],
                                    ),
                                    //Padding
                                    SizedBox(
                                      height: scaler.getWidth(1),
                                    ),
                                    //Postal Address
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                //Postal Address Text
                                                Container(
                                                  height: scaler.getWidth(5),
                                                  margin: EdgeInsets.only(
                                                      top: scaler.getWidth(1),
                                                      bottom: scaler.getWidth(.5)),
                                                  child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: RichText(
                                                          text: TextSpan(
                                                              text: "Postal Address",
                                                              style: GoogleFonts.lato(
                                                                  textStyle: TextStyle(
                                                                      fontSize: 17.5,
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
                                                // Residential Address TextField
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
                                                      postalAddress = input;
                                                    },
                                                    initialValue: postalAddress,
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
                                        SizedBox(
                                          height: scaler.getWidth(1),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                //City Postal Text
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
                                                // City TextField
                                                Container(
                                                  width: scaler.getWidth(35),
                                                  height: scaler.getWidth(10),
                                                  child: TextFormField(
                                                    validator: (input) {
                                                      if (input.isEmpty) {
                                                        return '';
                                                      }
                                                    },
                                                    onSaved: (input) {
                                                      cityPostal = input;
                                                    },
                                                    initialValue: cityPostal,
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
                                                //State Postal Text
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
                                                // State Postal TextField
                                                Container(
                                                  width: scaler.getWidth(35),
                                                  height: scaler.getWidth(10),
                                                  child: TextFormField(
                                                    validator: (input) {
                                                      if (input.isEmpty) {
                                                        return '';
                                                      }
                                                    },
                                                    onSaved: (input) {
                                                      statePostal = input;
                                                    },
                                                    initialValue: statePostal,
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
                                        SizedBox(
                                          height: scaler.getWidth(1),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            //Post Code PostalText
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
                                            // Postcode TextField
                                            Container(
                                              width: scaler.getWidth(35),
                                              height: scaler.getWidth(10),
                                              child: TextFormField(
                                                validator: (input) {
                                                  if (input.isEmpty) {
                                                    return '';
                                                  }
                                                },
                                                onSaved: (input) {
                                                  postcodePostal = input;
                                                },
                                                initialValue: postcodePostal,
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
                                          height: scaler.getWidth(1),
                                        ),
                                        //Country Container
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
                                                              .getDefaultFlagImage(countryP),
                                                          SizedBox(width: 8.0),
                                                          Container(
                                                              width: scaler.getWidth(60),
                                                              child: Text(
                                                                countryP.name,
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
                                                            onTap: _openCountryPostalPickerDialog,
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

                                      ],
                                    ),
                                    //Padding
                                    SizedBox(
                                      height: scaler.getWidth(1),
                                    ),
                                    //Row 6 of TextField
                                    Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            //Emergency Contact Text
                                            Container(
                                              height: scaler.getWidth(5),
                                              margin: EdgeInsets.only(
                                                  top: scaler.getWidth(1),
                                                  bottom: scaler.getWidth(.5)),
                                              child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: RichText(
                                                      text: TextSpan(
                                                          text: "Emergency Contact Name",
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
                                            // Emergency Contact TextField
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
                                                  emergencyContact = input;
                                                },
                                                initialValue: emergencyContact,
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
                                    //Row 7 Relationship
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //Relationship Text
                                        Container(
                                          height: scaler.getWidth(5),
                                          margin: EdgeInsets.only(
                                              top: scaler.getWidth(1),
                                              bottom: scaler.getWidth(.5)),
                                          child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: "Relationship",
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
                                        // Phone TextField
                                        Container(
                                          width: scaler.getWidth(50),
                                          height: scaler.getWidth(10),
                                          child: TextFormField(
                                            validator: (input) {
                                              if (input.isEmpty) {
                                                return '';
                                              }
                                            },
                                            onSaved: (input) {
                                              emergencyRel = input;
                                            },
                                            initialValue: emergencyRel,
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
                                      height: scaler.getWidth(4),
                                    ),
                                    //Row 8 Mobile Interview
                                    Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            //Mobile Text
                                            Container(
                                              height: scaler.getWidth(5),
                                              margin: EdgeInsets.only(
                                                  top: scaler.getWidth(1),
                                                  bottom: scaler.getWidth(.5)),
                                              child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: RichText(
                                                      text: TextSpan(
                                                        text: "Mobile (for your interview)",
                                                        style: GoogleFonts.lato(
                                                            textStyle: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                FontWeight.bold),
                                                            color: Colors.black),
                                                      ))),
                                            ),
                                            // Mobile TextField
                                            Container(
                                              width: scaler.getWidth(50),
                                              height: scaler.getWidth(10),
                                              child: TextFormField(
                                                onSaved: (input) {
                                                  mobileInt = input;
                                                },
                                                initialValue: mobileInt,
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
                                      ],
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
            setState(() => countryResident = country.name),
        itemBuilder: _buildDialogItem,
      ),
    ),
  );

  void _openCountryPostalPickerDialog() => showDialog(
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
            setState(() => countryPostal = country.name),
        itemBuilder: _buildDialogItem,
      ),
    ),
  );

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
          widget.userBloc.registerContactDetails(widget.userId, email, otherEmail, phoneNum, mobileNum, residentialAddress, cityResident, stateResident, countryResident, postcodeResident, postalAddress, cityPostal, statePostal, countryPostal, postcodePostal, emergencyContact, emergencyRel, mobileInt);
          Navigator.of(context).pop();
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
