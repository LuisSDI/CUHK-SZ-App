import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:cuhkszapp/Services/User/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatefulWidget {
  final User user;

  EditProfile({Key key, this.user}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String name;

  String countryField;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Scaffold(
      bottomNavigationBar: Container(
        height: scaler.getHeight(9),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff6747CD), Color(0x8C3300D6)])),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(
                left: scaler.getHeight(2), right: scaler.getHeight(2)),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  //Profile Text
                  Padding(
                    padding: EdgeInsets.only(
                      top: scaler.getHeight(7),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: scaler.getHeight(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xff6747CD), Color(0x8C3300D6)]),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        Container(
                          height: scaler.getHeight(5),
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              "Edit Profile",
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 36,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        Container(
                          width: scaler.getHeight(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xff6747CD), Color(0x8C3300D6)]),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: scaler.getHeight(2)),
                    child: Container(
                      height: scaler.getWidth(40),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                            Radius.circular(scaler.getWidth(20))),
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.user.photoUrL),
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes
                                    : null,
 