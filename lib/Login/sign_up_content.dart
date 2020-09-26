import 'package:cuhkszapp/Login/sign_in_page.dart';
import 'package:cuhkszapp/MainPages/home_page.dart';
import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'create_profile_page.dart';

class SignUpContent extends StatefulWidget {
  SignInPageState parent;
  SignUpContent(this.parent);
  @override
  _SignUpContentState createState() => _SignUpContentState();
}

class _SignUpContentState extends State<SignUpContent> {
  final myController = TextEditingController();
  UserBloc userBloc;
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    //Column of Sign Up
    return BlocProvider(
      bloc: UserBloc(),
      child: Padding(
        padding: EdgeInsets.only(
            left: scaler.getWidth(7), right: scaler.getWidth(7)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Hello Text
            Container(
              height: scaler.getWidth(7),
              child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'Hello,',
                    style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 31)),
                  )),
            ),
            //Sign up  Text
            Container(
              height: scaler.getWidth(8),
              margin: EdgeInsets.only(
                  top: scaler.getWidth(1), bottom: scaler.getWidth(7.5)),
              child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    """Enter your information below 
or login with a social account"""
                        .trim(),
                    style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 20, color: Color(0xff62626C))),
                  )),
            ),
            // Email TextField
            Container(
              width: scaler.getWidth(80),
              height: scaler.getWidth(5),
              margin: EdgeInsets.only(bottom: scaler.getWidth(6.5)),
              child: TextFormField(
                onSaved: (input) {
                  this.widget.parent.setState(() {
                    this.widget.parent.email = input;
                  });
                },
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please type an email';
                  }
                },
                style: TextStyle(fontSize: 18, color: Color(0xff62626C)),
                decoration: InputDecoration(
                    hintText: 'Email address',
                    hintStyle: GoogleFonts.lato(
                        textStyle: TextStyle(
                      fontSize: 18,
                    ))),
              ),
            ),
            // Password TextField
            Container(
              width: scaler.getWidth(80),
              height: scaler.getWidth(5),
              margin: EdgeInsets.only(bottom: scaler.getWidth(6.5)),
              child: TextFormField(
                onSaved: (input) {
                  this.widget.parent.setState(() {
                    this.widget.parent.password = input;
                  });
                },
                controller: myController,
                validator: (input) {
                  if (input.length < 6) {
                    return 'Your password needs to be at least 6 characters';
                  }
                },
                obscureText: true,
                style: TextStyle(fontSize: 18, color: Color(0xff62626C)),
                decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle:
                        TextStyle(fontSize: 18, color: Color(0xff62626C))),
              ),
            ),
            // Repeat Password TextField
            Container(
              width: scaler.getWidth(80),
              height: scaler.getWidth(5),
              child: TextFormField(
                validator: (input) {
                  if (input != myController.text) {
                    return 'Password is not matching';
                  }
                },
                obscureText: true,
                style: TextStyle(fontSize: 18, color: Color(0xff62626C)),
                decoration: InputDecoration(
                    hintText: 'Password again',
                    hintStyle:
                        TextStyle(fontSize: 18, color: Color(0xff62626C))),
              ),
            ),

            // Facebook and Google Icons
            Row(
              children: <Widget>[
                //FACEBOOK
                GestureDetector(
                  onTap: () async {
                    userBloc = BlocProvider.of(context);
                    AuthCredential credential =
                        await userBloc.credentialFacebook();
                    if (credential == null) {
                      widget.parent.scaffkey.currentState.showSnackBar(SnackBar(
                        duration: Duration(seconds: 3),
                        content: Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: Text(
                            userBloc.getError(),
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                              fontSize: 14,
                            )),
                          ),
                        ),
                      ));
                      userBloc.resetError();
                    } else {
                      AuthResult authResult =
                          await userBloc.signInCredential(credential);
                      print(authResult);
                      if (authResult.additionalUserInfo.isNewUser) {
                        authResult.user.delete();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateProfilePage(
                                      auth: FirebaseAuth.instance,
                                      credential: credential,
                                    )));
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      }
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      top: scaler.getWidth(3),
                    ),
                    alignment: Alignment.center,
                    child: FittedBox(
                        fit: BoxFit.contain,
                        child: Icon(
                          FontAwesome.facebook,
                          color: Colors.black,
                          size: 35,
                        )),
                    width: scaler.getWidth(10),
                    height: scaler.getWidth(10),
                  ),
                ), // GOOGLE
                GestureDetector(
                  onTap: () async {
                    userBloc = BlocProvider.of(context);
                    AuthCredential credential =
                        await userBloc.credentialGoogle();
                    if (credential == null) {
                      widget.parent.scaffkey.currentState.showSnackBar(SnackBar(
                        duration: Duration(seconds: 3),
                        content: Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: Text(
                            userBloc.getError(),
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                              fontSize: 14,
                            )),
                          ),
                        ),
                      ));
                      userBloc.resetError();
                    } else {
                      AuthResult authResult =
                          await userBloc.signInCredential(credential);
                      print(authResult);
                      if (authResult.additionalUserInfo.isNewUser) {
                        authResult.user.delete();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateProfilePage(
                                      auth: FirebaseAuth.instance,
                                      credential: credential,
                                    )));
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      }
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      top: scaler.getWidth(3),
                    ),
                    alignment: Alignment.center,
                    child: FittedBox(
                        fit: BoxFit.contain,
                        child: Icon(
                          FontAwesome.google,
                          color: Colors.black,
                          size: 35,
                        )),
                    width: scaler.getWidth(10),
                    height: scaler.getWidth(10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
