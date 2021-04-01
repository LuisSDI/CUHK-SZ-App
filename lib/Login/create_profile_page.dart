import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';
import 'package:cuhkszapp/Services/User/model/user.dart';
import 'package:cuhkszapp/resources/arrow_button.dart';
import 'package:cuhkszapp/resources/async_loader.dart';
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
  GlobalKey<ScaffoldState> scaffkey = GlobalKey();

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
  String countryCode = '86';
  String countryField = 'China';
  GlobalKey<ScaffoldState> scaffkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    Country country_phone =
        CountryPickerUtils.getCountryByPhoneCode(countryCode);
    Country country = CountryPickerUtils.getCountryByName(countryField);
    return BlocProvider(
      bloc: UserBloc(),
      child: Scaffold(
          key: scaffkey,
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
                                  "Create Profile",
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

                        // Dont worry... Text
                        Container(
                          height: scaler.getWidth(10),
                          margin: EdgeInsets.only(
                              top: scaler.getWidth(1),
                              bottom: scaler.getWidth(1)),
                          child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                """Don't worry...
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              )),
                        ),
                        // Full Name TextField
                        Container(
                          width: scaler.getWidth(70),
                          child: TextFormField(
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Please type your name';
                              }
                            },
                            onSaved: (input) {
                              name = input;
                            },
                            maxLength: 30,
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
                                fontSize: 14,
                              )),
                              errorStyle: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                fontSize: 16,
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
                          ),
                          child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                "Phone Number",
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              )),
                        ),
                        Container(
                          height: scaler.getHeight(9.1),
                          child: Row(
                            children: <Widget>[
                              // Country Code Container
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // Country Text
                                  Container(
                                    height: scaler.getWidth(4),
                                    margin: EdgeInsets.only(
                                        top: scaler.getWidth(1),
                                        bottom: scaler.getWidth(.5)),
                                    child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          "Country",
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        )),
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
                                        width: scaler.getHeight(18),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(width: 8.0),
                                            CountryPickerUtils
                                                .getDefaultFlagImage(
                                                    country_phone),
                                            SizedBox(width: 8.0),
                                            Expanded(
                                                child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                '+' + country_phone.phoneCode,
                                                textAlign: TextAlign.right,
                                                style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            )),
                                            SizedBox(width: 8.0),
                                            GestureDetector(
                                              child: Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Color(0xff6747CD),
                                              ),
                                              onTap:
                                                  _openCountryPickerPhoneDialog,
                                            )
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              // Number Container
                              Container(
                                margin:
                                    EdgeInsets.only(left: scaler.getWidth(4)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Number Text
                                    Container(
                                      height: scaler.getWidth(4),
                                      margin: EdgeInsets.only(
                                          top: scaler.getWidth(1),
                                          bottom: scaler.getWidth(.5)),
                                      child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            "Number",
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )),
                                    ),
                                    //  Number Field
                                    Expanded(
                                      child: Container(
                                        width: scaler.getWidth(35),
                                        child: TextFormField(
                                          validator: (input) {
                                            if (input.length < 8) {
                                              scaffkey.currentState
                                                  .showSnackBar(SnackBar(
                                                content: Container(
                                                  alignment: Alignment.center,
                                                  height: scaler.getHeight(2),
                                                  child: Text(
                                                    "Please type a valid number",
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
                                            phone = input;
                                          },
                                          keyboardType: TextInputType.number,
                                          maxLength: 13,
                                          style: GoogleFonts.lato(
                                              textStyle:
                                                  TextStyle(fontSize: 16)),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                left: scaler.getWidth(1)),
                                            hintText: '123456789',
                                            errorStyle: TextStyle(height: 0),
                                            counterText: '',
                                            hintStyle: GoogleFonts.lato(
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
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.red)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
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
                                      bottom: scaler.getWidth(.5)),
                                  child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "Nationality",
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                      )),
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
                        // I am ... Container
                        Row(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // I am a ... Text
                                Container(
                                  height: scaler.getWidth(5),
                                  margin: EdgeInsets.only(
                                      top: scaler.getWidth(1),
                                      bottom: scaler.getWidth(.5)),
                                  child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "I am a ...",
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 18,
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
                                              width: 1)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xff6747CD),
                                              width: 1)),
                                    ),
                                    value: dropdownValue,
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Color(0xff6747CD),
                                    ),
                                    iconSize: 24,
                                    elevation: 16,
                                    onChanged: (String newValue) {
                                      setState(() {
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
                              bottom: scaler.getWidth(.5)),
                          child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                "Personal Description",
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 18,
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
                                return 'Please type a description of yourself';
                              }
                            },
                            onSaved: (input) {
                              description = input;
                            },
                            maxLines: 5,
                            maxLength: 170,
                            keyboardType: TextInputType.text,
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(fontSize: 16)),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  left: scaler.getWidth(1),
                                  top: scaler.getWidth(1)),
                              hintText: 'Aa',
                              errorStyle: GoogleFonts.lato(
                                  textStyle: TextStyle(fontSize: 14)),
                              counterStyle: GoogleFonts.lato(
                                  textStyle: TextStyle(fontSize: 14)),
                              hintStyle: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                fontSize: 16,
                              )),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Color(0xff6747CD))),
                              focusColor: Color(0xff6747CD),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(0xff6747CD), width: 1)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(0xff6747CD), width: 1)),
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
  Widget _buildDialogItemPhone(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          Flexible(
            child: Text(
              '+' + country.phoneCode,
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

  void _openCountryPickerPhoneDialog() => showDialog(
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
                setState(() => countryCode = country.phoneCode),
            itemBuilder: _buildDialogItemPhone,
          ),
        ),
      );

  Future<void> registerUser() async {
    {
      final formState = _formKey.currentState;
      widget.userBloc = BlocProvider.of(context);
      var authResult;
      if (formState.validate()) {
        formState.save();
        try {
          if (widget.credential != null) {
            authResult = await widget.userBloc
                .signInCredential(widget.credential)
                .then((value) {
              Async_Loader.showLoadingDialog(context);
              if (value == null) {
                scaffkey.currentState.showSnackBar(SnackBar(
                  duration: Duration(seconds: 3),
                  content: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Text(
                      widget.userBloc.getError(),
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                        fontSize: 14,
                      )),
                    ),
                  ),
                ));
                widget.userBloc.resetError();
              } else {
                UserApp user = UserApp(
                    email: value.user.email,
                    name: name,
                    photoUrL: (value.user.photoUrl == null)
                        ? 'https://firebasestorage.googleapis.com/v0/b/cuhk-shenzhen-app.appspot.com/o/no_photo.png?alt=media&token=f444bdb5-4857-4c54-9268-2c7cf3970ca2'
                        : value.user.photoUrl,
                    uid: value.user.uid,
                    country: countryField,
                    description: description,
                    phone: '+$countryCode $phone',
                    type: dropdownValue);
                widget.userBloc.setUserData(user).whenComplete(() {
                  if (widget.userBloc.getErrorCloud() == null) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else {
                    value.user.delete();
                    widget.userBloc.signOut();
                    scaffkey.currentState.showSnackBar(SnackBar(
                      duration: Duration(seconds: 3),
                      content: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Text(
                          widget.userBloc.getErrorCloud(),
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                            fontSize: 14,
                          )),
                        ),
                      ),
                    ));
                    widget.userBloc.resetErrorCloud();
                  }
                });
              }
            });
          } else {
            Async_Loader.showLoadingDialog(context);
            await widget.userBloc
                .signUp(widget.email, widget.password)
                .then((value) {
              if (value == null) {
                scaffkey.currentState.showSnackBar(SnackBar(
                  duration: Duration(seconds: 3),
                  content: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Text(
                      widget.userBloc.getError(),
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                        fontSize: 14,
                      )),
                    ),
                  ),
                ));
                widget.userBloc.resetError();
              } else {
                UserApp user = UserApp(
                    email: value.email,
                    name: name,
                    photoUrL: (value.photoUrl == null)
                        ? 'https://firebasestorage.googleapis.com/v0/b/cuhk-shenzhen-app.appspot.com/o/no_photo.png?alt=media&token=f444bdb5-4857-4c54-9268-2c7cf3970ca2'
                        : value.photoUrl,
                    uid: value.uid,
                    country: countryField,
                    description: description,
                    phone: '+$countryCode $phone',
                    type: dropdownValue);
                widget.userBloc.setUserData(user).whenComplete(() {
                  if (widget.userBloc.getErrorCloud() == null) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else {
                    widget.userBloc.deleteUser();
                    widget.userBloc.signOut();
                    scaffkey.currentState.showSnackBar(SnackBar(
                      duration: Duration(seconds: 3),
                      content: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Text(
                          widget.userBloc.getErrorCloud(),
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                            fontSize: 14,
                          )),
                        ),
                      ),
                    ));
                    widget.userBloc.resetErrorCloud();
                  }
                });
              }
            });
          }
        } catch (e) {
          print(e);
          Navigator.of(context).pop();
        }
      }
    }
  }
}
