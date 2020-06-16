import 'package:cuhkszapp/Login/sign_in_page.dart';
import 'package:cuhkszapp/resources/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatelessWidget {
  String imageAssetPath, title, desc;
  OnboardingScreen({this.imageAssetPath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);

    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                },
                child: Container(
                    height: scaler.getWidth(10),
                    width: scaler.getWidth(10),
                    margin: EdgeInsets.only(
                      top: scaler.getWidth(5),
                      right: scaler.getWidth(5),
                    ),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "Skip",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: scaler.getWidth(8),
                margin:
                    EdgeInsets.only(bottom: scaler.getWidth(3),
                    top: scaler.getWidth(5)),
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      title,
                      style:
                          GoogleFonts.lato(textStyle: TextStyle(fontSize: 31)),
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: scaler.getWidth(22),
                padding: EdgeInsets.symmetric(
                    vertical: scaler.getWidth(1)),
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      desc,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                        fontSize: 22,
                        color: Color(0xff62626C),
                      )),
                    )),
              ),
            ],
          ),
          Container(
            height: scaler.getWidth(60),
            width: scaler.getWidth(60),
            margin: EdgeInsets.only(bottom: scaler.getWidth(5)),
            child: Image(
              image: AssetImage(imageAssetPath),
            ),
          ),
        ],
      ),
    );
  }
}
