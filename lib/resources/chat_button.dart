import 'package:cuhkszapp/MainPages/ChatPages/chat_screen.dart';
import 'package:cuhkszapp/MainPages/ChatPages/show_profile_screen.dart';
import 'package:cuhkszapp/Services/User/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatButton extends StatelessWidget {
  final User user;

  const ChatButton({Key key, @required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xff6747CD), width: 2),
          borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(scaler.getWidth(1)),
            child: Container(
                height: scaler.getWidth(18),
                width: scaler.getWidth(18),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(scaler.getWidth(10)),
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(user.photoUrL),
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: scaler.getWidth(18),
                        width: scaler.getWidth(18),
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                )),
          ),
          //Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  )),
                ),
                SizedBox(
                  height: scaler.getHeight(.5),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowProfileScreen(
                                  user: user,
                                )));
                  },
                  child: Text(
                    'Show Profile',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xff6747CD),
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
          //Open Chat
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChatScreen(
                user: user,
              )));
            },
            child: Container(
              child: Icon(
                Ionicons.ios_arrow_forward,
                color: Color(0xff6747CD),
                size: 40,
              ),
            ),
          )
        ],
      ),
    );
  }
}
