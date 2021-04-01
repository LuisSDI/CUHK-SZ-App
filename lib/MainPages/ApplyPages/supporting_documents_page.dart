import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuhkszapp/MainPages/ApplyPages/declaration_page.dart';
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

class SupportingDocumentsPage extends StatefulWidget {
  UserBloc userBloc;
  final String userId;

  SupportingDocumentsPage({Key key, this.userId}) : super(key: key);

  @override
  _SupportingDocumentsPageState createState() =>
      _SupportingDocumentsPageState();
}

class _SupportingDocumentsPageState extends State<SupportingDocumentsPage> {
  List<Widget> gridItemsPassport = [];
  List<String> passportFilenames = [];
  List<String> passportUrls = [];
  Widget dottedPassport;

  List<Widget> gridItemsStatement = [];
  List<String> statementFilenames = [];
  List<String> statementUrls = [];
  Widget dottedStatement;

  List<Widget> gridItemsOthers = [];
  List<String> othersFilenames = [];
  List<String> othersUrls = [];
  Widget dottedOthers;

  GlobalKey<ScaffoldState> _scaffkey = GlobalKey();
  Stream<DocumentSnapshot> _stream;

  @override
  void initState() {
    // Only create the stream once
    _stream = UserBloc().getSupportingMaterials(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: UserBloc(),
      child: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                Map supportingMaterials = snapshot.data.data;
                if (supportingMaterials != null) {
                  Map passportDoc = supportingMaterials['passport'];
                  Map statementDoc = supportingMaterials['personal statements'];
                  Map otherDoc = supportingMaterials['other material'];
                  if (passportDoc != null) {
                    passportFilenames =
                        passportDoc['passport name'].cast<String>();
                    passportUrls = passportDoc['passport urls'].cast<String>();
                  }

                  if (statementDoc != null) {
                    statementFilenames =
                        statementDoc['personal statements name'].cast<String>();
                    statementUrls =
                        statementDoc['personal statements urls'].cast<String>();
                  }

                  if (otherDoc != null) {
                    othersFilenames =
                        otherDoc['other material name'].cast<String>();
                    othersUrls = otherDoc['other material urls'].cast<String>();
                  }
                }
              }

              ScreenScaler scaler = ScreenScaler()..init(context);
              dottedPassport = Padding(
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
                            FilePickerResult result = await FilePicker.platform.pickFiles(
                                allowMultiple: true,
                              type: FileType.custom,
                              allowedExtensions: ['pdf'],
                            );
                            if(result != null) {
                              List<File> files = result.paths.map((path) => File(path)).toList();
                              List<File> filesToUpload = [];
                              for (var file in files) {
                                String filename = path.basename(file.path);
                                if (passportFilenames.contains(filename)) {
                                } else {
                                  passportFilenames.add(filename);
                                  filesToUpload.add(file);
                                }
                              }
                              uploadPassport(filesToUpload, passportFilenames);
                            } else {
                              // User canceled the picker
                            }
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
              gridItemsPassport.clear();
              for (var filename in passportFilenames) {
                gridItemsPassport.insert(
                    0, filePassportWidget(filename, scaler));
              }
              gridItemsPassport.add(dottedPassport);

              dottedStatement = Padding(
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
                            FilePickerResult result = await FilePicker.platform.pickFiles(
                                allowMultiple: true,
                              type: FileType.custom,
                              allowedExtensions: ['pdf'],
                            );

                            if(result != null) {
                              List<File> files = result.paths.map((path) => File(path)).toList();
                              List<File> filesToUpload = [];
                              for (var file in files) {
                                String filename = path.basename(file.path);
                                if (statementFilenames.contains(filename)) {
                                } else {
                                  statementFilenames.add(filename);
                                  filesToUpload.add(file);
                                }
                              }
                              uploadStatement(filesToUpload, statementFilenames);
                            } else {
                              // User canceled the picker
                            }
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
              gridItemsStatement.clear();
              for (var filename in statementFilenames) {
                gridItemsStatement.insert(
                    0, fileStatementWidget(filename, scaler));
              }
              gridItemsStatement.add(dottedStatement);

              dottedOthers = Padding(
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

                            FilePickerResult result = await FilePicker.platform.pickFiles(
                                allowMultiple: true,
                              type: FileType.custom,
                              allowedExtensions: ['pdf'],);

                            if(result != null) {
                              List<File> files = result.paths.map((path) => File(path)).toList();
                              List<File> filesToUpload = [];
                              for (var file in files) {
                                String filename = path.basename(file.path);
                                if (othersFilenames.contains(filename)) {
                                } else {
                                  othersFilenames.add(filename);
                                  filesToUpload.add(file);
                                }
                              }
                              uploadOthers(filesToUpload, othersFilenames);
                            } else {
                              // User canceled the picker
                            }

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
              gridItemsOthers.clear();
              for (var filename in othersFilenames) {
                gridItemsOthers.insert(0, fileOtherWidget(filename, scaler));
              }
              gridItemsOthers.add(dottedOthers);

              return Scaffold(
                  key: _scaffkey,
                  body: SingleChildScrollView(
                      child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: scaler.getWidth(2),
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //Buttom for back
                                Container(
                                  padding:
                                      EdgeInsets.only(top: scaler.getWidth(6)),
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
                                  padding:
                                      EdgeInsets.only(top: scaler.getWidth(7)),
                                  child: Text(
                                    '''8. Supporting\nMaterials'''.trim(),
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 31,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: scaler.getWidth(1),
                                  bottom: scaler.getWidth(1),
                                  right: scaler.getHeight(.5),
                                  left: scaler.getHeight(0)),
                              child: Text(
                                """Please submit the following documents and its translation if needed."""
                                    .trim(),
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff62626C))),
                              ),
                            ),

                            //Upload Files
                            //Passport
                            Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // 5.4 Text
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: scaler.getWidth(1),
                                          bottom: scaler.getWidth(.5)),
                                      child: RichText(
                                          text: TextSpan(
                                              text: '''Passport''',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  color: Colors.black),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: "*",
                                                  style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0xff6747CD))),
                                                )
                                              ])),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: gridItemsPassport.length,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: (scaler.getWidth(25) /
                                    scaler.getHeight(20)),
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return gridItemsPassport[index];
                              },
                            ),

                            //Personal Statement
                            Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Text
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: scaler.getWidth(1),
                                          bottom: scaler.getWidth(.5)),
                                      child: RichText(
                                          text: TextSpan(
                                              text: '''Personal Statement''',
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  color: Colors.black),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: "*",
                                                  style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0xff6747CD))),
                                                )
                                              ])),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: gridItemsStatement.length,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: (scaler.getWidth(25) /
                                    scaler.getHeight(20)),
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return gridItemsStatement[index];
                              },
                            ),
                            //Others
                            Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Text
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: scaler.getWidth(1),
                                          bottom: scaler.getWidth(.5)),
                                      child: RichText(
                                          text: TextSpan(
                                        text:
                                            '''Other Supporting Documents \n(Optional)''',
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                            color: Colors.black),
                                      )),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: gridItemsOthers.length,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: (scaler.getWidth(25) /
                                    scaler.getHeight(20)),
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return gridItemsOthers[index];
                              },
                            ),
                          ],
                        ),
                      ),
                      ArrowButtom(
                        onTap: () async {
                          if (passportFilenames.isNotEmpty &&
                              statementFilenames.isNotEmpty) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DeclarationPage(
                                          userId: widget.userId,
                                        )));
                          } else {
                            _scaffkey.currentState.showSnackBar(SnackBar(
                              duration: Duration(seconds: 2),
                              content: Container(
                                alignment: Alignment.center,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Text(
                                  "Please upload the required documents to procede",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                    fontSize: 14,
                                  )),
                                ),
                              ),
                            ));
                          }
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

  Widget filePassportWidget(String filename, ScreenScaler scaler) {
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
                        child:
                            Icon(AntDesign.pdffile1, color: Color(0xff6747CD))),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Color(0xff6747CD),
                  child: Text(
                    (filename.length < 10)
                        ? filename
                        : '${filename.substring(0, 8)}...',
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
                passportFilenames.remove(filename);
                widget.userBloc.deletePassportFile(widget.userId, filename);
                passportUrls = await widget.userBloc
                    .getOnlyLanguageUrl(widget.userId, passportFilenames);
                widget.userBloc.registerPassportUrl(
                    widget.userId, passportUrls, passportFilenames);
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

  Widget fileOtherWidget(String filename, ScreenScaler scaler) {
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
                        child:
                            Icon(AntDesign.pdffile1, color: Color(0xff6747CD))),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Color(0xff6747CD),
                  child: Text(
                    (filename.length < 10)
                        ? filename
                        : '${filename.substring(0, 8)}...',
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
                othersFilenames.remove(filename);
                widget.userBloc.deleteOtherFile(widget.userId, filename);
                passportUrls = await widget.userBloc
                    .getOnlyOthersUrl(widget.userId, othersFilenames);
                widget.userBloc.registerOtherUrl(
                    widget.userId, othersUrls, othersFilenames);
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

  Widget fileStatementWidget(String filename, ScreenScaler scaler) {
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
                        child:
                            Icon(AntDesign.pdffile1, color: Color(0xff6747CD))),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Color(0xff6747CD),
                  child: Text(
                    (filename.length < 10)
                        ? filename
                        : '${filename.substring(0, 8)}...',
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
                statementFilenames.remove(filename);
                widget.userBloc.deleteStatementFile(widget.userId, filename);
                statementUrls = await widget.userBloc
                    .getOnlyStatementUrl(widget.userId, statementFilenames);
                widget.userBloc.registerStatementUrl(
                    widget.userId, statementUrls, statementFilenames);
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

  Future<void> uploadPassport(
      List<File> files, List<String> transcriptFilenames) async {
    widget.userBloc = BlocProvider.of(context);
    try {
      for (int i = 0; i < files.length; i++) {
        passportUrls.add(await widget.userBloc
            .getUploadPassportUrl(widget.userId, files[i]));
      }
      print(passportUrls);
      print('Aqui');
      print(transcriptFilenames);
      widget.userBloc.registerPassportUrl(
          widget.userId, passportUrls, transcriptFilenames);
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

  Future<void> uploadStatement(
      List<File> files, List<String> transcriptFilenames) async {
    widget.userBloc = BlocProvider.of(context);
    try {
      for (int i = 0; i < files.length; i++) {
        statementUrls.add(await widget.userBloc
            .getUploadStatementsUrl(widget.userId, files[i]));
      }
      print(statementUrls);
      print('Aqui');
      print(transcriptFilenames);
      widget.userBloc.registerStatementUrl(
          widget.userId, statementUrls, transcriptFilenames);
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

  Future<void> uploadOthers(
      List<File> files, List<String> transcriptFilenames) async {
    widget.userBloc = BlocProvider.of(context);
    try {
      for (int i = 0; i < files.length; i++) {
        othersUrls.add(
            await widget.userBloc.getUploadOthersUrl(widget.userId, files[i]));
      }
      print(othersUrls);
      print('Aqui');
      print(transcriptFilenames);
      widget.userBloc
          .registerOtherUrl(widget.userId, othersUrls, transcriptFilenames);
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
