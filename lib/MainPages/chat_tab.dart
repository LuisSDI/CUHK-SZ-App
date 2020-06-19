import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';
import 'package:cuhkszapp/Services/User/model/user.dart';
import 'package:cuhkszapp/resources/chat_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatTab extends StatefulWidget {
  @override
  _ChatTabState createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return BlocProvider(
      bloc: UserBloc(),
      child: FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (context, snapshot) {
          UserBloc userBloc = BlocProvider.of(context);
          if (snapshot.hasData){
            FirebaseUser firebaseUser = snapshot.data;
            return FutureBuilder(
                  future: userBloc.getListUsers(firebaseUser.uid),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done){
                      List<User> users = snapshot.data;
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: scaler.getWidth(7),
                                  top: scaler.getWidth(7)),
                              child: Container(
                                height: scaler.getHeight(5),
                                alignment: Alignment.centerLeft,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    "Chats,",
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 36,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: scaler.getHeight(1)),
                              child: ListView.builder(itemBuilder: (context,index){
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: scaler.getHeight(2),
                                    vertical:scaler.getHeight(.5) ,),
                                  child: ChatButton(
                                    user: users[index],
                                  ),
                                );
                              },
                              itemCount: users.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    else{
                      return Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  }
                );
          }
          else{
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
      ),
    );
  }
}
