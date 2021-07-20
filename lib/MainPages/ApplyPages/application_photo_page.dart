import 'dart:io';

import 'package:cuhkszapp/MainPages/ApplyPages/study_preference_page.dart';
import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';
import 'package:cuhkszapp/resources/arrow_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ApplicationPhotoPage extends StatefulWidget {
  UserBloc userBloc;
  final String userId;

  ApplicationPhotoPage({Key key, this.userId}) : super(key: key);
  @override
  _ApplicationPhotoPageState createState() => _ApplicationPhotoPageState();
}

class _ApplicationPhotoPageState extends State<ApplicationPhotoPage> {

  GlobalKey<ScaffoldState> _scaffkey = GlobalKey();
  String photoUrl = '';
  File image;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: UserBloc(),
      child: StreamBuilder(
          stream: UserBloc().getApplicationPhoto(widget.userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                Map photoApplication = snapshot.data.data;
                if(photoApplication != null){
                  photoUrl = photoApplication['photoUrl'];
                }
              }
              photoUrl ??= '';
              ScreenScaler scaler = ScreenScaler()..init(context);
              return Scaffold(
                  key: _scaffkey,
                  body: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: scaler.getWidth(2),
                                top: scaler.getWidth(7)),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    //Buttom for back
                                    Container(
                                      child: IconButton(
                                        icon: Icon(
                                          Ionicons.ios_arrow_back,
                                          color: Color(0xff6747CD),
                                          size: 30,
                                        ),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    ),
                                    //Title Text
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '''1.8 Photo'''.trim(),
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 31,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                ),
                                // Intro Text
                                Container(
                                  margin: EdgeInsets.only(
                                      top: scaler.getWidth(1),
                                      bottom: scaler.getWidth(1),
                                      right: scaler.getHeight(.5),
                                      left: scaler.getHeight(0)),
                                  child: Text(
                                    '''Your photo must meet the following requirements (see sample image below):''',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff62626C))),
                                  ),
                                ),
                                //Photo Details and Sample photo
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: scaler.getWidth(50),
                                      margin: EdgeInsets.only(
                                          top: scaler.getWidth(1),
                                          right: scaler.getHeight(.5),
                                          left: scaler.getHeight(0)),
                                      child: Text(
                                        '''• A one-inch color photo (preferably taken within the last three months)

• JPEG file with high resolution (file dimensions: NO LESS than 300 * 448, file size NO LARGER than 500K)

• White background
''',
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black)),
                                      ),
                                    ),
                                    Container(
                                      width: scaler.getWidth(30),
                                      height: scaler.getHeight(25),
                                      decoration: BoxDecoration(
                                        borderRadius:BorderRadius.all(Radius.circular(5)),
                                        border: Border.all(color: Colors.black),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:BorderRadius.all(Radius.circular(5)),
                                        child: Image(
                                          image: AssetImage('assets/images_application/photo_sample.jpg'),
                                          width: scaler.getWidth(30),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //Continue of Photo Details
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: scaler.getWidth(85),
                                      margin: EdgeInsets.only(
                                          bottom: scaler.getWidth(1),
                                          right: scaler.getHeight(.5),
                                          left: scaler.getHeight(0)),
                                      child: Text(
                                        '''• You must be the only person in the picture, head and shoulders only.

• Face must be clearly visible and facing forward (ensure your face is well lit)

• No sunglasses, hats, graduation caps, gowns, costumes or other objects that mask identity (regular glasses are acceptable so long as they don't block your eyes)''',
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ],
                                ),
                                //Padding
                                SizedBox(
                                  height: scaler.getWidth(1),
                                ),
                                (photoUrl == '') ?
                                DottedBorder(
                                  color: Color(0xff6747CD),
                                  strokeWidth: 2,
                                  dashPattern: [8,4],
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    child: Container(
                                      width: scaler.getWidth(30),
                                      height: scaler.getHeight(25),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                          onTap: () async {
                                            ImagePicker picker = ImagePicker();
                                            await picker.getImage(source: ImageSource.gallery,imageQuality: 80,).then((imagePicked) {
                                              image = File(imagePicked.path);
                                              uploadApplicationPhoto(image);
                                            });

                                          },
                                          child: Container(
                                            height: scaler.getWidth(15),
                                            width: scaler.getWidth(15),
                                            padding: EdgeInsets.all(scaler.getWidth(1)),
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [Color(0xff6747CD), Color(0x8C3300D6)]),
                                                shape: BoxShape.circle
                                            ),
                                            child: FittedBox(
                                              fit: BoxFit.cover,
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ) :
                                Container(
                                  height: scaler.getHeight(28),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          width: scaler.getWidth(30),
                                          height: scaler.getHeight(25),
                                          decoration: BoxDecoration(
                                            //borderRadius:BorderRadius.all(Radius.circular(5)),
                                            border: Border.all(color: Color(0xff6747CD),
                                            width: 2),
                                          ),
                                          child:Image(
                                            image: NetworkImage(photoUrl),
                                            fit: BoxFit.cover,
                                            loadingBuilder: (BuildContext context,
                                                Widget child,
                                                ImageChunkEvent loadingProgress) {
                                              if (loadingProgress == null) return child;
                                              return Container(
                                                height: scaler.getWidth(40),
                                                width: scaler.getWidth(40),
                                                child: Center(
                                                  child: CircularProgressIndicator(
                                                    value: loadingProgress
                                                        .expectedTotalBytes !=
                                                        null
                                                        ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes
                                                        : null,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: scaler.getWidth(24),
                                        bottom: scaler.getHeight(21),
                                        child: Container(
                                          width: scaler.getHeight(4),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xff6747CD),
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color(0xff6747CD),
                                                  Color(0x8C3300D6)
                                                ]),
                                          ),
                                          child: IconButton(
                                            onPressed: () async {
                                              widget.userBloc = BlocProvider.of(context);
                                              widget.userBloc.registerApplicationPhoto(widget.userId, '');
                                              widget.userBloc.deleteApplicationPhoto(widget.userId);
                                              image = null;
                                              _scaffkey.currentState.showSnackBar(SnackBar(
                                                duration: Duration(seconds: 2),
                                                content: Container(
                                                  alignment: Alignment.center,
                                                  height: MediaQuery.of(context).size.height * 0.05,
                                                  child: Text(
                                                    "The photo has been deleted from the server",
                                                    style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                          fontSize: 14,
                                                        )),
                                                  ),
                                                ),
                                              ));

                                            },
                                            icon: Icon(
                                              Icons.clear,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //Padding
                                //Padding
                              ],
                            ),
                          ),
                          ArrowButtom(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StudyPreferencePage(
                                        userId: widget.userId,
                                      )));

                              //await uploadApplicationPhoto(image);
                            },
                          )
                        ],
                      )));
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

  Future<void> uploadApplicationPhoto(File imageFile) async {
    {
      widget.userBloc = BlocProvider.of(context);
        try {
          if ( imageFile == null) {
            _scaffkey.currentState.showSnackBar(SnackBar(
              duration: Duration(seconds: 2),
              content: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.05,
                child: Text(
                  "Please select a photo",
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 14,
                      )),
                ),
              ),
            ));
          }
          else{
            photoUrl = await widget.userBloc.getApplicationPhotoUrl(widget.userId, imageFile);
            widget.userBloc.registerApplicationPhoto(widget.userId, photoUrl);
            _scaffkey.currentState.showSnackBar(SnackBar(
              duration: Duration(seconds: 2),
              content: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.05,
                child: Text(
                  "The selected has been upload to the server",
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 14,
                      )),
                ),
              ),
            ));

          }
        } catch (e) {
          print(e.message);
          Navigator.of(context).pop();
      }
    }
  }


}
