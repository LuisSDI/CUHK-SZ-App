import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatelessWidget {
  String email;
  UserBloc userBloc;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return BlocProvider(
      bloc: UserBloc(),
      child: Scaffold(
        key: _scaffkey,
        body: Form(
          key: _formKey,
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: scaler.getHeight(5)),
                      child: Container(
                        alignment: Alignment.center,
                        width: scaler.getWidth(40),
                        height: scaler.getWidth(40),
                        child: Image(
                          image:
                          AssetImage("assets/images_onboarding/rounded icon.png"),
                        ),
                      ),
                    ),
                  ),
                  //Forgot Text
                  Padding(
                    padding: EdgeInsets.only(top: scaler.getHeight(1)),
                    child: Container(
                      height: scaler.getWidth(7),
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Forgot your password?',
                            style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 23)),
                          )),
                    ),
                  ),
                  //Subtitle Text
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: scaler.getHeight(1),
                    horizontal: scaler.getHeight(2)),
                    child: Container(
                      child: Text(
                        '''Enter your registered email below to receive password reset instruction''',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                            textStyle:
                            TextStyle(fontSize: 16, color: Color(0xff62626C))),
                      ),
                    ),
                  ),
                  // Email TextField
                  Padding(
                    padding: EdgeInsets.only(top: scaler.getHeight(4)),
                    child: Container(
                      width: scaler.getWidth(80),
                      height: scaler.getWidth(5),
                      child: TextFormField(
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Please type your email';
                          }
                        },
                        onSaved: (input) {
                          email = input;

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
                  ),
                  //Send button
                  Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: scaler.getHeight(3.5),
                    horizontal: scaler.getHeight(5)),
                    child: GestureDetector(
                      onTap: () async {
                        final formState = _formKey.currentState;
                        if (formState.validate()) {
                          formState.save();
                          userBloc = BlocProvider.of(context);
                          await userBloc.sendRecoveryPassword(email);
                          _scaffkey.currentState.showSnackBar(SnackBar(
                            content: Container(
                              alignment: Alignment.center,
                              height: scaler.getHeight(2),
                              child: Text(
                                "Check your email, we have sent a password recovery instruction to your email.",
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                    )),
                              ),
                            ),
                          ));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xff6747CD),
                                  Color(0x8C3300D6)
                                ]),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x80000000),
                                blurRadius: 4.0, // soften the shadow
                                spreadRadius: 0, //extend the shadow
                                offset: Offset(
                                  0, // Move to right 10  horizontally
                                  6, // Move to bottom 10 Vertically
                                ),
                              )
                            ]),
                        child: Container(
                          padding: EdgeInsets.all(scaler.getHeight(1)),
                          alignment: Alignment.center,
                          child: Text(
                            'Send',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  //height: .5,
                                  fontSize: 23,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Space
                  SizedBox(
                    height: scaler.getHeight(3),
                  ),
                  //Back to login Text
                  Padding(
                    padding: EdgeInsets.only(top: scaler.getHeight(1)),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        child: Text(
                          'Back to Login',
                          style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 18),
                          fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: scaler.getHeight(10),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff6747CD), Color(0x8C3300D6)])),
        ),
      ),
    );

  }
}
