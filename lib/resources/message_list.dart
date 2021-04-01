import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuhkszapp/Services/User/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageList extends StatelessWidget {

  final String currentUserId;
  final UserApp receiverUser;

  const MessageList({Key key, this.currentUserId, this.receiverUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('messages').doc(currentUserId)
          .collection(receiverUser.uid).orderBy('timeStamp',descending: true).snapshots()
      ,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.data == null){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
         return ListView.builder(
           padding: EdgeInsets.all(scaler.getWidth(2)),
           itemBuilder: (context, index) {
             return chatMessageItem(context, snapshot.data.docs[index]);
           },
           itemCount: snapshot.data.docs.length,
           reverse: true,
         );
      },
    );
  }

  Widget chatMessageItem(BuildContext context, DocumentSnapshot snapshot){
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: snapshot['senderId'] == currentUserId ? senderLayout(context , snapshot , Alignment.centerRight) :
        recieverLayout(context,snapshot, Alignment.centerLeft),
      ),
    );
  }

  Widget senderLayout(BuildContext context , DocumentSnapshot snapshot , Alignment alignment) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: scaler.getWidth(60)
        ),
        child:Padding(
          padding: EdgeInsets.all(scaler.getHeight(1)),
          child: Text(
            snapshot['message'],
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

  Widget recieverLayout(BuildContext context,DocumentSnapshot snapshot, Alignment alignment ) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(
            maxWidth: scaler.getWidth(60)
        ),
        child:Padding(
          padding: EdgeInsets.all(scaler.getHeight(1)),
          child: Text(
            snapshot['message'],
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
