import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';
import 'package:cuhkszapp/Services/User/model/messages.dart';
import 'package:cuhkszapp/Services/User/model/user.dart';
import 'package:cuhkszapp/resources/custom_app_bar.dart';
import 'package:cuhkszapp/resources/message_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {

  TextEditingController _textEditingController = TextEditingController();
  bool isWritting = false;


  final UserModel user;
  final String currentUserUid;

  final GlobalKey<ScaffoldState> _scaffkey = GlobalKey();



  ChatScreen({Key key, @required this.user, this.currentUserUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return SafeArea(
      top: false,
      child: BlocProvider(
        bloc: UserBloc(),
        child:Scaffold(
          key: _scaffkey,
          body: Column(
            children: <Widget>[
              Flexible(
                child: MessageList(currentUserId: currentUserUid,
                  receiverUser: user,),
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
                    //TextField to Send Messages
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
                    GestureDetector(
                      onTap: () async {
                        if(_textEditingController.text.length == 0 || _textEditingController.text.trim() == ''){
                          _scaffkey.currentState.showSnackBar(SnackBar(
                            content: Container(
                              alignment: Alignment.center,
                              height: scaler.getHeight(2),
                              child: Text(
                                "Unable to send an empty message",
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                    )),
                              ),
                            ),
                            duration: Duration(seconds: 1),
                          ));
                        }
                        else{
                          UserBloc userBloc = BlocProvider.of(context);
                          User currentUser =  userBloc.currentUser;
                          UserModel sender = await userBloc.getUserData(currentUser.uid);
                          Message _message = Message(
                            receiverId: user.uid,
                            senderId: currentUser.uid,
                            message: _textEditingController.text,
                            timeStamp: FieldValue.serverTimestamp(),
                          );
                          userBloc.addMessage(_message, sender, user);
                          _textEditingController.clear();
                        }
                      },child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(1)),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),)
                  ],
                ),

              )
            ],
          ),
          appBar: CustomAppBar(user: user,),
        ),
        ),
      );
  }



  setWriting(bool val) {
    isWritting = val;
  }
}
