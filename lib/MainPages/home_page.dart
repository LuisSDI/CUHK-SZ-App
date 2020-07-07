import 'package:cuhkszapp/MainPages/chat_tab.dart';
import 'package:cuhkszapp/MainPages/discover_tab.dart';
import 'package:cuhkszapp/MainPages/explore_tab.dart';
import 'package:cuhkszapp/MainPages/profile_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'apply_tab.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  int _currentIndex = 0;
  final List<Widget> _children = [
    ExploreTab(),
    DiscoverTab(),
    ChatTab(),
    ApplyTab(),
    ProfileTab(),
  ];
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    double paddingBottombar = scaler.getHeight(0.5);
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff6747CD), Color(0x8C3300D6)])),
        child: BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            iconSize: 18,
            backgroundColor: Colors.transparent,
            items: [
              //Explore
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(paddingBottombar),
                    child: Icon(
                      FontAwesome.university,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  title: Text(
                    "Explore",
                    style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                  backgroundColor: Colors.transparent),
              //Majors
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(paddingBottombar),
                    child: Icon(
                      FontAwesome.graduation_cap,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  title: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "Majors",
                      style: GoogleFonts.lato(
                          textStyle:
                              TextStyle(fontSize: 12, color: Colors.white)),
                    ),
                  ),
                  backgroundColor: Colors.transparent),
              //Messages
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(paddingBottombar),
                    child: Icon(
                      Ionicons.ios_chatboxes,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  title: Text(
                    "Messages",
                    style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                  backgroundColor: Colors.transparent),
              //Apply
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(paddingBottombar),
                    child: Icon(
                      AntDesign.form,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  title: Text(
                    "Apply",
                    style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                  backgroundColor: Colors.transparent),
              //Profile
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(paddingBottombar),
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  title: Text(
                    "Profile",
                    style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                  backgroundColor: Colors.transparent),
            ]),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
