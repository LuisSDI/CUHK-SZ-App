import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:cuhkszapp/Services/User/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowProfileScreen extends StatelessWidget {

  final UserModel user;

  const ShowProfileScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Country country = CountryPickerUtils.getCountryByName(user.country);
    ScreenScaler scaler = ScreenScaler()..init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Container(
          child: Padding(
            padding: EdgeInsets.only(
                left: scaler.getHeight(2), right: scaler.getHeight(2)),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // Title Row
                  Padding(
                    padding: EdgeInsets.only(
                        top: scaler.getHeight(7),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //Back Button
                        GestureDetector(
                          child: Container(
                            child: Icon(
                              Ionicons.ios_arrow_back,
                              color: Color(0xff6747CD),
                              size: 36,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        //Profile Text
                        Container(
                          height: scaler.getHeight(5),
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              "Profile",
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 36,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        //Edit Profile Button
                      ],
                    ),
                  ),

                  //Profile Picture
                  Padding(
                    padding: EdgeInsets.only(top: scaler.getHeight(1)),
                    child: Container(
                      height: scaler.getWidth(40),
                      width: scaler.getWidth(40),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                            Radius.circular(scaler.getWidth(20))),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image(
                            image: NetworkImage(user.photoUrL),
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                height: scaler.getWidth(40),
                                width: scaler.getWidth(40),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                        null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes
                                        : null,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Name Field
                  Padding(
                    padding: EdgeInsets.only(top: scaler.getHeight(2)),
                    child: Stack(children: [
                      Container(
                        height: scaler.getHeight(5),
                        width: scaler.getHeight(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xff6747CD), Color(0x8C3300D6)]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Text(
                              'Name',
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: scaler.getHeight(.5)),
                        alignment: Alignment.centerRight,
                        height: scaler.getHeight(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xff6747CD),
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            user.name,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  //Country Field
                  Padding(
                    padding: EdgeInsets.only(top: scaler.getHeight(2)),
                    child: Stack(children: [
                      Container(
                        height: scaler.getHeight(5),
                        width: scaler.getHeight(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xff6747CD), Color(0x8C3300D6)]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Country',
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: scaler.getHeight(.5)),
                        alignment: Alignment.centerRight,
                        height: scaler.getHeight(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xff6747CD),
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Container(
                            width: scaler.getHeight(33),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                CountryPickerUtils.getDefaultFlagImage(country),
                                SizedBox(width: 8.0),
                                Flexible(
                                    child: Text(
                                      country.name,
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  // I am a ... Field
                  Padding(
                    padding: EdgeInsets.only(top: scaler.getHeight(2)),
                    child: Stack(children: [
                      Container(
                        height: scaler.getHeight(5),
                        width: scaler.getHeight(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xff6747CD), Color(0x8C3300D6)]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Text(
                              'I am a ...',
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: scaler.getHeight(.5)),
                        alignment: Alignment.centerRight,
                        height: scaler.getHeight(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xff6747CD),
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            user.type,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  // Description Field
                  Padding(
                    padding: EdgeInsets.only(top: scaler.getHeight(2)),
                    child: Container(
                      child: Stack(children: [
                        Container(
                          height: scaler.getHeight(5),
                          alignment: Alignment(0, .5),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xff6747CD), Color(0x8C3300D6)]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Text(
                                'Description',
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: scaler.getHeight(.5)),
                          alignment: Alignment.topLeft,
                          height: scaler.getHeight(20),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xff6747CD),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.only(top: scaler.getHeight(5)),
                            child: Text(
                              user.description,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: scaler.getHeight(1),
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
