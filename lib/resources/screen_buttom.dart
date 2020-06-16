import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenButtom extends StatefulWidget {
  String detail = 'Test';
  IconData iconData = AntDesign.flag;
  Widget screen = Scaffold();

  ScreenButtom({Key key, this.detail, this.iconData, this.screen})
      : super(key: key);
  @override
  _ScreenButtomState createState() => _ScreenButtomState();
}

class _ScreenButtomState extends State<ScreenButtom> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    widget.screen ??= Scaffold();
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget.screen));
      },
      child: Container(
        height: scaler.getHeight(16),
        width: scaler.getHeight(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff6747CD), Color(0x8C3300D6)]),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: scaler.getHeight(5),
              child: FittedBox(
                child: Icon(
                  widget.iconData,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            SizedBox(
              height: scaler.getHeight(1),
            ),
            Container(
              alignment: Alignment.center,
              height: scaler.getHeight(4.2),
              child: Text(
                widget.detail,
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                  //height: .5,
                  fontSize: 16,
                  color: Colors.white,
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
