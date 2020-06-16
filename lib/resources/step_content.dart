import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class StepContent extends StatelessWidget {
  final String text;
  final IconData iconData;

  const StepContent({Key key, this.text, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Column(
      children: [
        Container(
          height: scaler.getHeight(12),
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: scaler.getWidth(1.5)),
          child: Container(
            height: scaler.getWidth(60),
            width: scaler.getWidth(60),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff6747CD),
            ),
            child: Padding(
              padding: EdgeInsets.all(scaler.getWidth(10)),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Icon(
                  iconData,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
