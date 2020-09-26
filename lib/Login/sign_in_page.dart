import 'package:cuhkszapp/Login/create_profile_page.dart';
import 'package:cuhkszapp/Login/sign_in_content.dart';
import 'package:cuhkszapp/Login/sign_up_content.dart';
import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';
import 'package:cuhkszapp/resources/arrow_button.dart';
import 'package:cuhkszapp/resources/async_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInPage extends StatefulWidget {
  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  String email, password;
  UserBloc userBloc;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffkey = GlobalKey();
  Widget _myAnimatedWidget;
  bool isSignIn = true;
  final GlobalKey<State> keyLoader = new GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return signInUI();
  }

  Widget signInUI() {
    ScreenScaler scaler = ScreenScaler()..init(context);
    if (isSignIn) {
      _myAnimatedWidget = SignInContent(this);
    }
    return Scaffold(
      key: scaffkey,
      body: Form(
        key: _formKey,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: scaler.getHeight(5), bottom: scaler.getWidth(2)),
                  width: scaler.getWidth(30),
                  height: scaler.getWidth(30),
                  child: Image(
                    image:
                        AssetImage("assets/images_onboarding/rounded icon.png"),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Sign In Container
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: scaler.getWidth(8),
                            vertical: scaler.getWidth(2.5)),
                        height: scaler.getWidth(15),
                        width: scaler.getWidth(45),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _myAnimatedWidget = SignInContent(this);
                              isSignIn = true;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: scaler.getWidth(0.5)),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: isSignIn
                                            ? Color(0xff62626C)
                                            : Colors.transparent,
                                        width: 1))),
                            child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  "Sign In",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 28,
                                          color: isSignIn
                                              ? Colors.black
                                              : Color(0xff62626C))),
                                )),
                          ),
                        ),
                      ),
                      //Sign Up Contanier
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: scaler.getWidth(8),
                            vertical: scaler.getWidth(2.5)),
                        height: scaler.getWidth(15),
                        width: scaler.getWidth(45),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _myAnimatedWidget = SignUpContent(this);
                              isSignIn = false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: scaler.getWidth(0.5)),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: isSignIn
                                            ? Colors.transparent
                                            : Color(0xff62626C),
                                        width: 1))),
                            child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  "Sign Up",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 28,
                                          color: isSignIn
                                              ? Color(0xff62626C)
                                              : Colors.black)),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Column of Sign In Content
                Container(
                  width: scaler.getWidth(100),
                  height: scaler.getHeight(46),
                  child: AnimatedSwitcher(
                    child: _myAnimatedWidget,
                    duration: Duration(milliseconds: 1600),
                  ),
                ),
                ArrowButtom(
                  onTap: () {
                    isSignIn ? signIn() : signUp();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        Async_Loader.showLoadingDialog(context);
        userBloc = BlocProvider.of(context);
        userBloc.signIn(email, password).then((value) {
          print(value);
          Navigator.pop(context);
          if (value == null) {
            scaffkey.currentState.showSnackBar(SnackBar(
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
          }
        });
      } catch (e) {
        print(e.message);
      }
    }
  }

  Future<void> signUp() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreateProfilePage(
                    email: email,
                    password: password,
                    auth: FirebaseAuth.instance,
                  )));
    }
  }
}
