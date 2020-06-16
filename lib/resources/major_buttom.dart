import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class MajorButtom extends StatefulWidget {
  String detail = 'Test';
  String image = "";
  Alignment alignment;
  Widget screen = Scaffold();

  MajorButtom({Key key, this.detail, this.image, this.screen, this.alignment})
      : super(key: key);

  @override
  _MajorButtomState createState() => _MajorButtomState();
}

class _MajorButtomState extends State<MajorButtom> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    widget.screen ??= Scaffold();
    widget.alignment ??= Alignment.center;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget.screen));
      },
      child: Container(
        height: scaler.getHeight(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 7,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: AssetImage(
                    widget.image,
                  ),
                  fit: BoxFit.fitHeight,
                  alignment: widget.alignment,
                  height: scaler.getHeight(16),
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Container(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    widget.detail,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            //height: .5,
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
