import 'dart:io';
import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';
import 'package:cuhkszapp/resources/arrow_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:path/path.dart' as path;

import 'education_history_page.dart';

class SchoolTranscriptPage extends StatefulWidget {
  UserBloc userBloc;
  final String userId;

  SchoolTranscriptPage({Key key, this.userId}) : super(key: key);

  @override
  _SchoolTranscriptPageState createState() => _SchoolTranscriptPageState();
}

class _SchoolTranscriptPageState extends State<SchoolTranscriptPage> {
  GlobalKey<ScaffoldState> _scaffkey = GlobalKey();
  String photoUrl = '';
  File image;
  List<Widget> gridItems = [];
  List<String> transcriptFilenames = [];
  List<String> transcriptUrls = [];
  Widget dotted;

  @override
  Widget build(BuildContext context) {
    Map transcriptsUrlName;
    return BlocProvider(
      bloc: UserBloc(),
      child: StreamBuilder(
          stream: UserBloc().getTranscriptsUrlsNames(widget.userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                transcriptsUrlName = snapshot.data.data;
                if (transcriptsUrlName != null) {
                  transcriptFilenames =
                      transcriptsUrlName['school transcripts name']
                          .cast<String>();
                  transcriptUrls = transcriptsUrlName['school transcripts urls']
                      .cast<String>();
                }
              }
              if (transcriptsUrlName != null) {
                transcriptFilenames =
                    transcriptsUrlName['school transcripts name']
                        .cast<String>();
                transcriptUrls = transcriptsUrlName['school transcripts urls']
                    .cast<String>();
              }
              ScreenScaler scaler = ScreenScaler()..init(context);
              dotted = Padding(
                padding: const EdgeInsets.all(8.0),
                child: DottedBorder(
                  color: Color(0xff6747CD),
                  strokeWidth: 2,
                  dashPattern: [8, 4],
                  borderType: BorderType.RRect,
                  radius: Radius.circular(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: Container(
                      width: scaler.getWidth(25),
                      height: scaler.getHeight(21),
                      child: Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () async {
                            List<File> files = await FilePicker.getMultiFile(
                              type: FileType.custom,
                              allowedExtensions: ['pdf'],
                            );
                            List<File> filesToUpload = [];
                            for (var file in files) {
                              String filename = path.basename(file.path);
                              if(transcriptFilenames.contains(filename)){

                              }
                              else{
                              transcriptFilenames.add(filename);
                              filesToUpload.add(file);
                              }
                            }
                            uploadTranscripts(filesToUpload, transcriptFilenames);
                          },
                          child: Container(
                            height: scaler.getWidth(10),
                            width: scaler.getWidth(10),
                            padding: EdgeInsets.all(scaler.getWidth(1)),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xff6747CD),
                                      Color(0x8C3300D6)
                                    ]),
                                shape: BoxShape.circle),
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
                ),
              );
              gridItems.clear();
              for (var filename in transcriptFilenames) {
                gridItems.insert(0, fileWidget(filename, scaler));
              }
              gridItems.add(dotted);

              return Scaffold(
                  key: _scaffkey,
                  body: SingleChildScrollView(
                      child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            left: scaler.getWidth(2),
                            right: scaler.getWidth(2),
                            top: scaler.getWidth(7)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    '''3. School Transcript '''.trim(),
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
                                '''Where a document is not in English, it must be accompanied by a certified English translation by a sworn translator, court translator, authorized public translator, certified translator, expert translator or an official translator. The original certificates/academic transcripts will normally be required for verification upon admission.''',
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff62626C))),
                              ),
                            ),
                            //Instructions Text
                            Container(
                              margin: EdgeInsets.only(
                                  top: scaler.getWidth(1),
                                  bottom: scaler.getWidth(.5)),
                              child: RichText(
                                  text: TextSpan(
                                      text:
                                          '''Please upload in PDF format your high school transcripts from the last 3 years, and its translation if need it.'''
                                              .trim(),
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                          color: Colors.black),
                                      children: <TextSpan>[
                                    TextSpan(
                                      text: "*",
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff6747CD))),
                                    )
                                  ])),
                            ),
                            //Files Grid
                            GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: gridItems.length,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: (scaler.getWidth(25) /
                                    scaler.getHeight(20)),
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return gridItems[index];
                              },
                            ),
                            SizedBox(
                              height: scaler.getHeight(7.1),
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
                                      builder: (context) => EducationHistoryPage(
                                        userId: widget.userId,
                                      )));

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

  Widget fileWidget(String filename, ScreenScaler scaler) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.bottomCenter,
            width: scaler.getWidth(25),
            height: scaler.getHeight(21),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xff6747CD), width: 2),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(scaler.getWidth(2)),
                    child: FittedBox(
                        child: Icon(AntDesign.pdffile1,color: Color(0xff6747CD))),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Color(0xff6747CD),
                    child: Text((filename.length < 10) ?
                      filename : '${filename.substring(0,8)}...',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.normal)),
                    ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: scaler.getWidth(17),
          bottom: scaler.getHeight(17),
          child: Container(
            width: scaler.getHeight(4),
            margin: EdgeInsets.all(scaler.getWidth(2)),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff6747CD),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff6747CD), Color(0x8C3300D6)]),
            ),
            child: GestureDetector(
              onTap: () async {
                widget.userBloc = BlocProvider.of(context);
                transcriptFilenames.remove(filename);
                widget.userBloc.deleteTranscriptFile(widget.userId, filename);
                transcriptUrls = await widget.userBloc
                    .getOnlyTranscriptsUrl(widget.userId, transcriptFilenames);
                widget.userBloc.registerSchoolTranscripts(
                    widget.userId, transcriptUrls, transcriptFilenames);
                _scaffkey.currentState.showSnackBar(SnackBar(
                  duration: Duration(seconds: 2),
                  content: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Text(
                      "The file has been deleted from the server",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                        fontSize: 14,
                      )),
                    ),
                  ),
                ));
              },
              child: Icon(
                Icons.clear,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> uploadTranscripts(
      List<File> files, List<String> transcriptFilenames) async {
    {
      widget.userBloc = BlocProvider.of(context);
      try {
        for (int i = 0; i < files.length; i++){
          transcriptUrls.add(
          await widget.userBloc
              .getUploadTranscriptsUrl(widget.userId, files[i]));
        }
        print(transcriptUrls);
        print('Aqui');
        print(transcriptFilenames);
        widget.userBloc.registerSchoolTranscripts(
            widget.userId, transcriptUrls, transcriptFilenames);
        print('Done');
        _scaffkey.currentState.showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          content: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.05,
            child: Text(
              "Your files have been upload to the server",
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                fontSize: 14,
              )),
            ),
          ),
        ));
      } catch (e) {
        print(e.message);
        Navigator.of(context).pop();
      }
    }
  }
}
