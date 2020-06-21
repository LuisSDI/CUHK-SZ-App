import 'package:cuhkszapp/Services/User/model/user.dart';
import 'package:cuhkszapp/resources/custom_app_bar.dart';
import 'package:cuhkszapp/resources/message_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {

  TextEditingController _textEditingController = TextEditingController();
  bool isWritting = false;


  final User user;

  ChatScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Flexible(
              child: MessageList(),
            ),
            //Chat Text Field
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff6747CD), Color(0x8C3300D6)])),
              child:Row(
                children: [
                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: scaler.getHeight(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _textEditingController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          onChanged: (value) {
                            //(value.length > 0 || value.trim() == '') ? setWriting(true) : setWriting(false);
                          },
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: scaler.getHeight(1),
                              vertical: scaler.getWidth(1)
                            ),
                            isDense: true,
                            hintStyle: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                )),
                            counterText: '',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            )
          ],
        ),
        appBar: CustomAppBar(user: user,),
      ),
    );
  }

  setWriting(bool val) {
    isWritting = val;
  }
}
