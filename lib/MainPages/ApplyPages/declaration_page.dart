import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuhkszapp/MainPages/home_page.dart';
import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';
import 'package:cuhkszapp/resources/arrow_button.dart';
import 'package:cuhkszapp/resources/check_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class DeclarationPage extends StatefulWidget {
  UserBloc userBloc;
  final String userId;

  DeclarationPage({Key key, this.userId}) : super(key: key);

  @override
  _DeclarationPageState createState() => _DeclarationPageState();
}

class _DeclarationPageState extends State<DeclarationPage> {
  bool hasAccepted = false;
  GlobalKey<ScaffoldState> _scaffkey = GlobalKey();

  @override
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);

    return BlocProvider(
        bloc: UserBloc(),
        child: Scaffold(
          key: _scaffkey,
          body: SingleChildScrollView(
              child: Column(children: <Widget>[
            Container(
                padding: EdgeInsets.only(
                  left: scaler.getWidth(2),
                ),
                child: Column(children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //Buttom for back
                      Container(
                        padding: EdgeInsets.only(top: scaler.getWidth(6)),
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
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: scaler.getWidth(7)),
                        child: Text(
                          '''9. Declaration'''.trim(),
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 31,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: scaler.getWidth(1),
                        bottom: scaler.getWidth(1),
                        right: scaler.getHeight(.5),
                        left: scaler.getHeight(0)),
                    child: Text(
                      """I certify that the information given in this application is correct and complete, and I will provide all of the necessary supporting documents in the Documents section which follows. I agree that The Chinese University of Hong Kong, Shenzhen may process personal data contained in this form , or other data which the University may obtain from me or other people whilst I am an applicant and student, for any purposes connected with my application or for any other legitimate reason."""
                          .trim(),
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 16, color: Color(0xff62626C))),
                    ),
                  ),
                ])),
            //Checkbox
            CheckboxListTile(
              title: Text(
                '''I agree to abide by the statues, regulations and policies of The Chinese University of Hong Kong, Shenzhen.'''
                    .trim(),
                style: GoogleFonts.lato(
                    textStyle:
                        TextStyle(fontSize: 14, color: Color(0xff6747CD))),
              ),
              value: hasAccepted,
              onChanged: (newValue) {
                setState(() {
                  hasAccepted = newValue;
                  print(hasAccepted);
                });
              },
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
            //Padding
            SizedBox(
              height: scaler.getHeight(26),
            ),
            CheckButtom(
              onTap: () async {
                if (hasAccepted) {
                  _showMyDialog();
                } else {
                  _scaffkey.currentState.showSnackBar(SnackBar(
                    duration: Duration(seconds: 2),
                    content: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Text(
                        "Please agree in order to process your application",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                          fontSize: 14,
                        )),
                      ),
                    ),
                  ));
                }
              },
            ),
          ])),
        ));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Submit Application',
            style: GoogleFonts.lato(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Once your application is submitted, you wouldn\'t be able to do any changes. Confirm submission?',
                  style: GoogleFonts.lato(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'CANCEL',
                style: GoogleFonts.lato(
                    color: Color(0xFF6747CD),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                'SUBMIT',
                style: GoogleFonts.lato(
                    color: Color(0xFF6747CD),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                print(widget.userId);
                widget.userBloc = BlocProvider.of(context);
                widget.userBloc.registerApplication(widget.userId);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
