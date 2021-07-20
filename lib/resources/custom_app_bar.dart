import 'package:cuhkszapp/MainPages/ChatPages/show_profile_screen.dart';
import 'package:cuhkszapp/Services/User/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {


  final UserModel user;

  const CustomAppBar({Key key, this.user}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff6747CD), Color(0x8C3300D6)])),
      child: Padding(
        padding: EdgeInsets.only(top: scaler.getHeight(1)),
        child: Padding(
          padding: EdgeInsets.only(left: scaler.getHeight(1),
          top: scaler.getHeight(1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Back Button
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  child: Icon(
                    Ionicons.ios_arrow_back,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              //Profile Picture
              Container(
                height: scaler.getHeight(6),
                width: scaler.getHeight(6),
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
                          color: Colors.white,
                          child: Center(
                            child: CircularProgressIndicator(
                              //valueColor: AlwaysStoppedAnimation(Colors.white),
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
              SizedBox(
                width: scaler.getHeight(1),
              ),
              //Contact Name
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Name Text
                  Text(
                    user.name,
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                  //User Status
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Online',
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Expanded(child: Container()),
              Padding(
                padding: EdgeInsets.only(right: scaler.getHeight(2)),
                child: Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowProfileScreen(user: user,)));
                    },
                    icon: Icon(
                      MaterialCommunityIcons.account_circle,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),


              //View Profile Button
            ],
          ),
        ),
      ),
    );
  }


  final Size preferredSize = const Size.fromHeight(kToolbarHeight + 10);
  
  
}