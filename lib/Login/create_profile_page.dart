import 'package:country_list_pick/country_list_pick.dart';
import 'package:cuhkszapp/MainPages/home_page.dart';
import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';
import 'package:cuhkszapp/Services/User/model/user.dart';
import 'package:cuhkszapp/resources/arrow_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateProfilePage extends StatefulWidget {
  UserBloc userBloc;
  FirebaseAuth auth;
  AuthCredential credential;
  String email;
  String password;
  final GlobalKey<State> keyLoader = new GlobalKey<State>();

  CreateProfilePage(
      {Key key, this.email, this.password, this.credential, this.auth})
      : super(key: key);
  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String dropdownValue = 'Student';
  String name, phone, description;
  String country_code = '+86';
  String country = 'China';

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return BlocProvider(
      bloc: UserBloc(),
      child: Scaffold(
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
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: FittedBox(
                                fit: BoxFit.contain,
                                child: Icon(
                                  AntDesign.left,
                                  color: Color(0xff6747cd),
                                  size: 30,
                                )),
                            width: scaler.getWidth(6),
                            height: scaler.getWidth(8),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: scaler.getWidth(4)),
                          height: scaler.getWidth(7),
                          child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Create Profile',
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 31,
                                        fontWeight: FontWeight.bold)),
                              )),
                        ),
                        // Dont worry... Text
                        Container(
                          height: scaler.getWidth(10),
                          margin: EdgeInsets.only(
                              top: scaler.getWidth(1),
                              bottom: scaler.getWidth(1)),
                          child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                """Dont worry...
you can change this info later"""
                                    .trim(),
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xff62626C))),
                              )),
                        ),
                        // Full Name Text
                        Container(
                          height: scaler.getWidth(5),
                          margin: EdgeInsets.only(
                              top: scaler.getWidth(1),
                              bottom: scaler.getWidth(1)),
                          child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                "Full Name",
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              )),
                        ),
                        // Full Name TextField
                        Container(
                          width: scaler.getWidth(80),
                          height: scaler.getWidth(12),
                          child: TextFormField(
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Please type a name';
                              }
                            },
                            onSaved: (input) {
                              name = input;
                            },
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(fontSize: 18)),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: scaler.getWidth(0.8)),
                              hintText: 'Aa',
                              hintStyle: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                fontSize: 18,
                              )),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Color(0xff6747CD))),
                              focusColor: Color(0xff6747CD),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(0xff6747CD), width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(0xff6747CD), width: 2)),
                            ),
                          ),
                        ),
                        // Phone Number Text
                        Container(
                          height: scaler.getWidth(5),
                          margin: EdgeInsets.only(
                              top: scaler.getWidth(1),
                              bottom: scaler.getWidth(1)),
                          child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                "Phone Number",
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              )),
                        ),
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
                                      bottom: scaler.getWidth(1)),
                                  child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "Country",
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      )),
                                ),
                                // Country Code Field
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Color(0xff6747CD), width: 2),
                                  ),
                                  child: CountryListPick(
                                    // to show or hide flag
                                    isShowFlag: false,
                                    // true to show  title country or false to code phone country
                                    isShowTitle: true,
                                    // to show or hide down icon
                                    isDownIcon: true,
                                    // to initial code number country
                                    initialSelection: '+86',
                                    // to get feedback data from picker
                                    onChanged: (CountryCode code) {
                                      // name of country
                                      country_code = code.dialCode;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // Number Container
                            Container(
                              margin: EdgeInsets.only(left: scaler.getWidth(4)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // Number Text
                                  Container(
                                    height: scaler.getWidth(5),
                                    margin: EdgeInsets.only(
                                        top: scaler.getWidth(1),
                                        bottom: scaler.getWidth(1)),
                                    child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          "Number",
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        )),
                                  ),
                                  //  Number Field
                                  Container(
                                    width: scaler.getWidth(35),
                                    height: scaler.getWidth(12),
                                    child: TextFormField(
                                      validator: (input) {
                                        if (input.length < 8) {
                                          return 'Invalid number';
                                        }
                                      },
                                      onSaved: (input) {
                                        phone = input;
                                      },
                                      keyboardType: TextInputType.number,
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(fontSize: 16)),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            left: scaler.getWidth(1)),
                                        hintText: '123456789',
                                        hintStyle: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                          fontSize: 18,
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
                                                width: 2)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Color(0xff6747CD),
                                                width: 2)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        // Nationality Container
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
                                      bottom: scaler.getWidth(1)),
                                  child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "Nationality",
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      )),
                                ),
                                // Country Code Field
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Color(0xff6747CD), width: 2),
                                  ),
                                  child: CountryListPick(
                                    // to show or hide flag
                                    isShowFlag: true,
                                    // true to show  title country or false to code phone country
                                    isShowTitle: true,
                                    // to show or hide down icon
                                    isDownIcon: true,
                                    // to initial code number country
                                    initialSelection: '+86',
                                    // to get feedback data from picker
                                    onChanged: (CountryCode code) {
                                      // name of country
                                      country = code.name;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // I am ... Container
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
                                      bottom: scaler.getWidth(1)),
                                  child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "I am a...",
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      )),
                                ),
                                // I am a ... Field
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
                                              width: 2)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xff6747CD),
                                              width: 2)),
                                    ),
                                    value: dropdownValue,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        print(newValue);
                                        dropdownValue = newValue;
                                      });
                                    },
                                    items: <String>[
                                      'Student',
                                      'Parent',
                                      'Other'
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
                            // Number Container
                          ],
                        ),
                        // Personal Description Text
                        Container(
                          height: scaler.getWidth(5),
                          margin: EdgeInsets.only(
                              top: scaler.getWidth(1),
                              bottom: scaler.getWidth(0)),
                          child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                "Personal Description",
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              )),
                        ),
                        // Personal Description TextField
                        Container(
                          width: scaler.getWidth(80),
                          height: scaler.getWidth(40),
                          child: TextFormField(
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Please type a name';
                              }
                            },
                            onSaved: (input) {
                              description = input;
                              print(description);
                            },
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(fontSize: 18)),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  left: scaler.getWidth(1),
                                  top: scaler.getWidth(1)),
                              hintText: 'Aa',
                              hintStyle: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                fontSize: 18,
                              )),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Color(0xff6747CD))),
                              focusColor: Color(0xff6747CD),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(0xff6747CD), width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(0xff6747CD), width: 2)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ArrowButtom(
                    onTap: () async {
                      registerUser();
                    },
                  )
                ],
              )))),
    );
  }

  Future<void> registerUser() async {
    {
      final formState = _formKey.currentState;
      widget.userBloc = BlocProvider.of(context);
      AuthResult authResult;
      FirebaseUser firebaseUser;
      if (formState.validate()) {
        formState.save();
        try {
          print(widget.credential);
          if (widget.credential != null) {
            authResult =
                await widget.userBloc.signInCredential(widget.credential);
            firebaseUser = authResult.user;
          } else {
            firebaseUser =
                await widget.userBloc.signUp(widget.email, widget.password);
          }
          User user = User(
              email: firebaseUser.email,
              name: name,
              photoUrL: (firebaseUser.photoUrl == null)
                  ? 'https://firebasestorage.googleapis.com/v0/b/cuhk-shenzhen-app.appspot.com/o/no_photo.png?alt=media&token=f444bdb5-4857-4c54-9268-2c7cf3970ca2'
                  : firebaseUser.photoUrl,
              uid: firebaseUser.uid,
              country: country,
              description: description,
              phone: '$country_code $phone',
              type: dropdownValue);
          widget.userBloc.setUserData(user);
        } catch (e) {
          print(e.message);
          Navigator.of(context).pop();
        }
      }
    }
  }
}
