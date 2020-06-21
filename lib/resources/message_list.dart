import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index){
      return chatMessageItem(context);
    },
    itemCount: 6,
    padding: EdgeInsets.all(10),
    );
  }

  Widget chatMessageItem(BuildContext context){
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: senderLayout(context),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: recieverLayout(context),
          )
        ],
      ),
    );
  }

  Widget senderLayout(BuildContext context  ) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: scaler.getWidth(60)
        ),
        child:Padding(
          padding: EdgeInsets.all(scaler.getHeight(1)),
          child: Text(
            'Hello',
            style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    )),
          ),
        ),

        decoration: BoxDecoration(
          color: Color(0xff6747CD),
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
      ),
    );
  }

  Widget recieverLayout(BuildContext context  ) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
            maxWidth: scaler.getWidth(60)
        ),
        child:Padding(
          padding: EdgeInsets.all(scaler.getHeight(1)),
          child: Text(
            'Hello ',
            style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                )),
          ),
        ),

        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
      ),
    );
  }

}
