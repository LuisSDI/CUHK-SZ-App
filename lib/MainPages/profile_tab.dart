import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:cuhkszapp/MainPages/edit_profile.dart';
import 'package:cuhkszapp/Services/User/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';

class ProfileTab extends StatelessWidget {
  UserBloc userBloc;
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return BlocProvider(
      bloc: UserBloc(),
      child: FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (context, snapshot) {
          userBloc = BlocProvider.of(context);
          User user;
          if (snapshot.hasData) {
            FirebaseUser firebaseUser = snapshot.data;
            return StreamBuilder(
                stream: userBloc.listenUserData(firebaseUser.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    DocumentSnapshot value = snapshot.data;
                    user = User(
                      name: value.data['full name'],
                      type: value.data['type'],
                      phone: value.data['phone'],
                      description: value.data['description'],
                      country: value.data['country'],
                      uid: value.data['uid'],
                      photoUrL: value.data['photoURL'],
                      email: value.data['email'],
                    );
                    return Profile(scaler, user, context);
                  } else {
                    return Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                });
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget Profile(ScreenScaler scaler, User user, BuildContext context) {
    Country country = CountryPickerUtils.getCountryByName(user.country);
    return SafeArea(
      top: false,
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
                      left: scaler.getWidth(7) - scaler.getHeight(2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Profile Text
                      Container(
                        height: scaler.getHeight(5),
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            "Profile,",
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 36,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      //Edit Profile Button
                      Container(
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile(
                                          user: user,
                                        )));
                          },
                          icon: Icon(
                            MaterialCommunityIcons.account_edit,
                            color: Color(0xff6747CD),
                            size: 36,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Profile Picture
                Padding(
                  padding: EdgeInsets.only(top: scaler.getHeight(2)),
                  child: Container(
                    height: scaler.getWidth(40),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                          Radius.circular(scaler.getWidth(20))),
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(user.photoUrL),
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
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
                //Sign out button
                Padding(
                  padding: EdgeInsets.only(
                      top: scaler.getHeight(2), bottom: scaler.getHeight(2)),
                  child: Container(
                    padding: EdgeInsets.all(scaler.getHeight(.5)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xff6747CD), Color(0x8C3300D6)]),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        //Signout
                        await FirebaseAuth.instance
                            .signOut()
                            .then((value) => print("Sesion Cerrada"));
                        },
                      icon: Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
