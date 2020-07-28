import 'package:cuhkszapp/MainPages/ApplyPages/school_transcript_page.dart';
import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';
import 'package:cuhkszapp/resources/arrow_button.dart';
import 'package:cuhkszapp/resources/expandable_tile.dart';
import "package:flutter/material.dart";
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class StudyPreferencePage extends StatefulWidget {
  UserBloc userBloc;
  final String userId;

  StudyPreferencePage({Key key, this.userId}) : super(key: key);
  @override
  _StudyPreferencePageState createState() => _StudyPreferencePageState();
}

class _StudyPreferencePageState extends State<StudyPreferencePage> {
  GlobalKey<ScaffoldState> _scaffkey = GlobalKey();
  List<String> selectedMajor = [];
  static const List SMEMajors = <String>[
    'Economics',
    'Marketing',
    'Finance',
    'Global Business Studies',
    'Professional Accounting',
    'Financial Engineering'
  ];

  static const List SSEMajors = <String>[
    'Computer Science & Engineering',
    'Electric Information Engineering',
    'New Energy Science & Engineering',
    'Mathematics & Applied \nMathematics',
    'Statistics'
  ];

  static const List HSSMajors = <String>[
    'Translation',
    'Applied Psychology',
    'English Studies',
  ];

  static const List LHSMajors = <String>[
    'Bioinformatic',
    'Biomedical Science and Engineering'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: UserBloc(),
      child: StreamBuilder(
          stream: UserBloc().getSelectedMajor(widget.userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                print(snapshot.data.data);
                Map selectMajor = snapshot.data.data;
                if (selectMajor != null) {
                  selectedMajor.clear();
                  selectedMajor.add(selectMajor['selected major']);
                }
              }
              print(selectedMajor);
              ScreenScaler scaler = ScreenScaler()..init(context);
              return Scaffold(
                  key: _scaffkey,
                  body: SingleChildScrollView(
                      child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: scaler.getWidth(2),
                          top: scaler.getWidth(7),
                          right: scaler.getWidth(2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    '''2. Study Preference'''.trim(),
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 31,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                            //Picture to fill the space
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: scaler.getWidth(2), vertical: scaler.getWidth(4)),
                              child: Container(
                                height: scaler.getHeight(20),
                                child: Image(
                                  image:
                                  AssetImage("assets/images_entry_screen/entry_picture_1.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                //SME Selection
                                ExpansionItem(
                                  title: 'School of Management and Economics (SME)',
                                  special: Container(
                                    color: Color(0xff6747CD),
                                    child: Column(
                                      children: <Widget>[
                                        CheckboxGroup(
                                          labels: SMEMajors,
                                          onSelected: (List<String> selected) {
                                            selectedMajor.clear();
                                            print('Sel SME');
                                            print(selected);
                                            for (var item in selected) {
                                              selectedMajor.add(item);
                                            }
                                            print('List');
                                            print(selectedMajor);
                                          },
                                          labelStyle: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          checkColor: Color(0xff6747CD),
                                          activeColor: Colors.white,
                                          checked: selectedMajor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Padding
                                SizedBox(
                                  height: scaler.getHeight(2),
                                ),
                                //SSE Selection
                                ExpansionItem(
                                  title: 'School of Science and Engineering (SSE)',
                                  special: Container(
                                    color: Color(0xff6747CD),
                                    child: Column(
                                      children: <Widget>[
                                        CheckboxGroup(
                                          labels: SSEMajors,
                                          onSelected: (List<String> selected) {
                                            selectedMajor.clear();
                                            print('Sel SSE');
                                            print(selected);
                                            for (var item in selected) {
                                              selectedMajor.add(item);
                                            }
                                            print('List');
                                            print(selectedMajor);
                                          },
                                          labelStyle: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          checkColor: Color(0xff6747CD),
                                          activeColor: Colors.white,
                                          checked: selectedMajor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Padding
                                SizedBox(
                                  height: scaler.getHeight(2),
                                ),
                                //HSS Selection
                                ExpansionItem(
                                  title: 'School of Humanities and Social Science (HSS)',
                                  special: Container(
                                    color: Color(0xff6747CD),
                                    child: Column(
                                      children: <Widget>[
                                        CheckboxGroup(
                                          labels: HSSMajors,
                                          onSelected: (List<String> selected) {
                                            selectedMajor.clear();
                                            for (var item in selected) {
                                              selectedMajor.add(item);
                                            }
                                            print('List');
                                            print(selectedMajor);
                                          },
                                          labelStyle: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          checkColor: Color(0xff6747CD),
                                          activeColor: Colors.white,
                                          checked: selectedMajor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Padding
                                SizedBox(
                                  height: scaler.getHeight(2),
                                ),
                                //LHS Selection
                                ExpansionItem(
                                  title: 'School of Life and Health Sciences (LHS)',
                                  special: Container(
                                    color: Color(0xff6747CD),
                                    child: Column(
                                      children: <Widget>[
                                        CheckboxGroup(
                                          labels: LHSMajors,
                                          onSelected: (List<String> selected) {
                                            selectedMajor.clear();
                                            print(selected);
                                            for (var item in selected) {
                                              selectedMajor.add(item);
                                            }
                                            print('List');
                                            print(selectedMajor);
                                          },
                                          labelStyle: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          checkColor: Color(0xff6747CD),
                                          activeColor: Colors.white,
                                          checked: selectedMajor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Padding
                                SizedBox(
                                  height: scaler.getHeight(2),
                                ),
                              ],
                            )
                            

                          ],
                        ),
                      ),
                      ArrowButtom(
                        onTap: () async {
                          await registerPersonalDetails();
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
  Future<void> registerPersonalDetails() async {
    {
      widget.userBloc = BlocProvider.of(context);
      if (selectedMajor.length == 1) {
        try {
          widget.userBloc.registerSelectedMajor(widget.userId, selectedMajor.first);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SchoolTranscriptPage(
                    userId: widget.userId,
                  )));

        } catch (e) {
          print(e.message);
          Navigator.of(context).pop();
        }
      }
      else if(selectedMajor.length > 1){
        _scaffkey.currentState.showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            alignment: Alignment.center,
            child: Text(
              "Please only select one major",
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 14,
                  )),
            ),
          ),
        ));
      }
      else{
        _scaffkey.currentState.showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            alignment: Alignment.center,
            child: Text(
              "Please select one major to proceed",
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 14,
                  )),
            ),
          ),
        ));
      }
    }
  }

}
