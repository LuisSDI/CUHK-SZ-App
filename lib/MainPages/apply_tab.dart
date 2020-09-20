import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuhkszapp/MainPages/ApplyPages/personal_details_page.dart';
import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return BlocProvider(
      bloc: UserBloc(),
      child: FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              FirebaseUser firebaseUser = snapshot.data;
              UserBloc userBloc = BlocProvider.of(context);
              return StreamBuilder<Object>(
                  stream: userBloc.getUserInfo(firebaseUser.uid),
                  builder: (context, snapshot) {
                    String statusAplication;
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        DocumentSnapshot documentSnapshot = snapshot.data;
                        Map userInfo = documentSnapshot.data;
                        if (userInfo['status of application'] != null) {
                          statusAplication = userInfo['status of application'];
                        }
                      }
                      return SafeArea(
                        top: false,
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: scaler.getWidth(7),
                                right: scaler.getWidth(7)),
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  //Discover Text
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: scaler.getWidth(7),
                                        bottom: scaler.getHeight(3)),
                                    child: Container(
                                      height: scaler.getHeight(5),
                                      alignment: Alignment.centerLeft,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          "Apply,",
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 36,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  (statusAplication == 'Finish')
                                      ?
                                      //Has apply
                                      Column(
                                          children: [
                                            Container(
                                              height: scaler.getHeight(35),
                                              width: scaler.getHeight(35),
                                              child: FittedBox(
                                                fit: BoxFit.cover,
                                                child: Icon(
                                                  Icons.check_circle,
                                                  color: Color(0xff6747CD),
                                                ),
                                              ),
                                            ),
                                            //Warning Text
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      scaler.getHeight(5)),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '''Your aplication has been successful. Please be aware of your email we will contact you very soon.''',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                    fontSize: 23,
                                                    color: Colors.black,
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      :
                                      //Hasn't Apply
                                      //Apply Icon
                                      Column(
                                          children: [
                                            Container(
                                              height: scaler.getHeight(35),
                                              width: scaler.getHeight(35),
                                              child: FittedBox(
                                                fit: BoxFit.cover,
                                                child: Icon(
                                                  MaterialCommunityIcons
                                                      .file_document_edit_outline,
                                                  color: Color(0xff6747CD),
                                                ),
                                              ),
                                            ),
                                            //Warning Text
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      scaler.getHeight(1)),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '''Before you start please
make sure you have
all the entry requirements
                          ''',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                    fontSize: 23,
                                                    color: Colors.black,
                                                  )),
                                                ),
                                              ),
                                            ),
                                            //Application Button
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom:
                                                      scaler.getHeight(2.5)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PersonalDetailsPage(
                                                                userId:
                                                                    firebaseUser
                                                                        .uid,
                                                              )));
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Color(0xff6747CD),
                                                            Color(0x8C3300D6)
                                                          ]),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color:
                                                              Color(0x80000000),
                                                          blurRadius:
                                                              4.0, // soften the shadow
                                                          spreadRadius:
                                                              0, //extend the shadow
                                                          offset: Offset(
                                                            0, // Move to right 10  horizontally
                                                            6, // Move to bottom 10 Vertically
                                                          ),
                                                        )
                                                      ]),
                                                  child: Container(
                                                    padding: EdgeInsets.all(
                                                        scaler.getHeight(1)),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'Let\'s Start',
                                                      textAlign:
                                                          TextAlign.center,
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
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
//                     return SafeArea(
//                       top: false,
//                       child: Container(
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                               left: scaler.getWidth(7),
//                               right: scaler.getWidth(7)),
//                           child: SingleChildScrollView(
//                             child: Column(
//                               children: <Widget>[
//                                 //Discover Text
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                       top: scaler.getWidth(7),
//                                       bottom: scaler.getHeight(3)),
//                                   child: Container(
//                                     height: scaler.getHeight(5),
//                                     alignment: Alignment.centerLeft,
//                                     child: FittedBox(
//                                       fit: BoxFit.contain,
//                                       child: Text(
//                                         "Apply,",
//                                         style: GoogleFonts.lato(
//                                             textStyle: TextStyle(
//                                                 fontSize: 36,
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.bold)),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 //Apply Icon
//                                 Container(
//                                   height: scaler.getHeight(35),
//                                   width: scaler.getHeight(35),
//                                   child: FittedBox(
//                                     fit: BoxFit.cover,
//                                     child: Icon(
//                                       MaterialCommunityIcons
//                                           .file_document_edit_outline,
//                                       color: Color(0xff6747CD),
//                                     ),
//                                   ),
//                                 ),
//                                 //Warning Text
//                                 Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       vertical: scaler.getHeight(1)),
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       '''Before you start please
// make sure you have
// all the entry requirements
//                           ''',
//                                       textAlign: TextAlign.center,
//                                       style: GoogleFonts.lato(
//                                           textStyle: TextStyle(
//                                         fontSize: 23,
//                                         color: Colors.black,
//                                       )),
//                                     ),
//                                   ),
//                                 ),
//                                 //Application Button
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                       bottom: scaler.getHeight(2.5)),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   PersonalDetailsPage(
//                                                     userId: firebaseUser.uid,
//                                                   )));
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(30),
//                                           gradient: LinearGradient(
//                                               begin: Alignment.topCenter,
//                                               end: Alignment.bottomCenter,
//                                               colors: [
//                                                 Color(0xff6747CD),
//                                                 Color(0x8C3300D6)
//                                               ]),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: Color(0x80000000),
//                                               blurRadius:
//                                                   4.0, // soften the shadow
//                                               spreadRadius:
//                                                   0, //extend the shadow
//                                               offset: Offset(
//                                                 0, // Move to right 10  horizontally
//                                                 6, // Move to bottom 10 Vertically
//                                               ),
//                                             )
//                                           ]),
//                                       child: Container(
//                                         padding:
//                                             EdgeInsets.all(scaler.getHeight(1)),
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           'Let\'s Start',
//                                           textAlign: TextAlign.center,
//                                           style: GoogleFonts.lato(
//                                               textStyle: TextStyle(
//                                             //height: .5,
//                                             fontSize: 23,
//                                             color: Colors.white,
//                                           )),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
                  });
            } else {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}
