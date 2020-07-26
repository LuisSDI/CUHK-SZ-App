import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuhkszapp/MainPages/ApplyPages/additional_details_page.dart';
import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';
import 'package:cuhkszapp/resources/arrow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalQuestionsPage extends StatefulWidget {

  UserBloc userBloc;
  final String userId;

  PersonalQuestionsPage({Key key, this.userId}) : super(key: key);

  @override
  _PersonalQuestionsPageState createState() => _PersonalQuestionsPageState();
}

class _PersonalQuestionsPageState extends State<PersonalQuestionsPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffkey = GlobalKey();
  String questionOne;
  String questionTwo;
  String questionThree;

  Stream<DocumentSnapshot> _stream;



  void initState() {
    // Only create the stream once
    _stream = UserBloc().getPersonalQuestion(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: UserBloc(),
      child: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active){
              if(snapshot.hasData){
                Map personalQuestion = snapshot.data.data;
                if(personalQuestion != null){
                  questionOne = personalQuestion['attributes question'];
                  questionTwo = personalQuestion['why china question'];
                  questionThree = personalQuestion['ambitions question'];
                }
              }
              ScreenScaler scaler = ScreenScaler()..init(context);
              return Scaffold(
                  key: _scaffkey,
                  body: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    left: scaler.getWidth(3), top: scaler.getWidth(7)),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //Buttom for back
                                        Container(
                                          child: IconButton(
                                            icon: Icon(
                                              Ionicons.ios_arrow_back,
                                              color: Color(0xff6747CD),
                                              size: 30,
                                            ),
                                            onPressed: () => Navigator.of(context).pop(),
                                          ),
                                        ),
                                        //Title Text
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '''1.3 Personal 
Questionnaires'''.trim(),
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
                                        '''Please write 50-100 words to answer each of the following questions.''',
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 16, color: Color(0xff62626C))),
                                      ),
                                    ),
                                    //Question 1 of TextField
                                    Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            // Question 1 Text
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: scaler.getWidth(1),
                                                  bottom: scaler.getWidth(.5)),
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: '''1.3.1 To encourage academic excellence,
The Chinese University of Hong Kong, 
Shenzhen offers a generous range of 
scholarships for international students. 
Please describe any special attributes or 
accomplishments that you think make you 
deserving of a scholarship. (Academic 
achievements are of primary importance, 
but you might want to consider other 
factors [especially those related to your
field of study] such as your reasons for 
applying to this course or extra-curricular 
achievements.)'''.trim(),
                                                      style: GoogleFonts.lato(
                                                          textStyle: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                          color: Colors.black),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: "*",
                                                          style: GoogleFonts.lato(
                                                              textStyle: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  color:
                                                                  Color(0xff6747CD))),
                                                        )
                                                      ])),
                                            ),
                                            // Question 3 TextField
                                            Container(
                                              width: scaler.getWidth(86),
                                              margin: EdgeInsets.only(
                                                right: scaler.getWidth(3)
                                              ),
                                              child: TextFormField(
                                                validator: (input) {
                                                  if (input.length < 300) {
                                                    return 'Your anwser is too short.';
                                                  }
                                                },
                                                onSaved: (input) {
                                                  questionOne = input;
                                                },
                                                initialValue: questionOne,
                                                maxLength: 625,
                                                maxLines: 15,
                                                keyboardType: TextInputType.text,
                                                style: GoogleFonts.lato(
                                                    textStyle: TextStyle(fontSize: 16)),
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.only(
                                                      left: scaler.getWidth(1),
                                                      top: scaler.getWidth(2)),
                                                  hintText: 'Aa',
                                                  counterText: '',
                                                  errorStyle: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontSize: 14
                                                      )
                                                  ),
                                                  counterStyle: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontSize: 14
                                                      )
                                                  ),
                                                  hintStyle: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                        fontSize: 16,
                                                      )),
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide:
                                                      BorderSide(color: Color(0xff6747CD))),
                                                  focusColor: Color(0xff6747CD),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide: BorderSide(
                                                          color: Color(0xff6747CD), width: 1)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide: BorderSide(
                                                          color: Color(0xff6747CD), width: 1)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                        // Number Container
                                      ],
                                    ),
                                    //Padding
                                    SizedBox(
                                      height: scaler.getWidth(1),
                                    ),
                                    //Question 2 of TextField
                                    Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            // Question 2 Text
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: scaler.getWidth(1),
                                                  bottom: scaler.getWidth(.5)),
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: '''1.3.2 You could study anywhere in the 
world ... why do you want to study in 
China? (You may wish to refer to past, 
present and future inspiration to answer 
this question.) Furthermore, what is the 
biggest challenge you expect to face while
living and studying in China? How will you
overcome it?.'''.trim(),
                                                      style: GoogleFonts.lato(
                                                          textStyle: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                          color: Colors.black),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: "*",
                                                          style: GoogleFonts.lato(
                                                              textStyle: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  color:
                                                                  Color(0xff6747CD))),
                                                        )
                                                      ])),
                                            ),
                                            // Question 2 TextField
                                            Container(
                                              width: scaler.getWidth(86),
                                              margin: EdgeInsets.only(
                                                  right: scaler.getWidth(3)
                                              ),
                                              child: TextFormField(
                                                validator: (input) {
                                                  if (input.length < 300) {
                                                    return 'Your anwser is too short.';
                                                  }
                                                },
                                                onSaved: (input) {
                                                  questionTwo = input;
                                                },
                                                initialValue: questionTwo,
                                                maxLength: 625,
                                                maxLines: 15,
                                                keyboardType: TextInputType.text,
                                                style: GoogleFonts.lato(
                                                    textStyle: TextStyle(fontSize: 16)),
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.only(
                                                      left: scaler.getWidth(1),
                                                      top: scaler.getWidth(2)),
                                                  hintText: 'Aa',
                                                  counterText: '',
                                                  errorStyle: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontSize: 14
                                                      )
                                                  ),
                                                  counterStyle: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontSize: 14
                                                      )
                                                  ),
                                                  hintStyle: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                        fontSize: 16,
                                                      )),
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide:
                                                      BorderSide(color: Color(0xff6747CD))),
                                                  focusColor: Color(0xff6747CD),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide: BorderSide(
                                                          color: Color(0xff6747CD), width: 1)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide: BorderSide(
                                                          color: Color(0xff6747CD), width: 1)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                        // Number Container
                                      ],
                                    ),
                                    //Padding
                                    SizedBox(
                                      height: scaler.getWidth(1),
                                    ),
                                    //Question 3 of TextField
                                    Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            // Question 3 Text
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: scaler.getWidth(1),
                                                  bottom: scaler.getWidth(.5)),
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: '''1.3.3 We seek students with clear goals 
for their future. Please share your 
ambitions and how studying your chosen 
programme at the Chinese University of
Hong Kong, Shenzhen will help you to 
achieve this? (Explain what has 
attracted you to study at the Chinese 
University of Hong Kong, Shenzhen, as
well as outlining your ultimate 
career goals.)'''.trim(),
                                                      style: GoogleFonts.lato(
                                                          textStyle: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                          color: Colors.black),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: "*",
                                                          style: GoogleFonts.lato(
                                                              textStyle: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  color:
                                                                  Color(0xff6747CD))),
                                                        )
                                                      ])),
                                            ),
                                            // Question 3 TextField
                                            Container(
                                              width: scaler.getWidth(86),
                                              margin: EdgeInsets.only(
                                                  right: scaler.getWidth(3)
                                              ),
                                              child: TextFormField(
                                                validator: (input) {
                                                  if (input.length < 300) {
                                                    return 'Your anwser is too short.';
                                                  }
                                                },
                                                onSaved: (input) {
                                                  questionThree = input;
                                                },
                                                initialValue: questionThree,
                                                maxLength: 625,
                                                maxLines: 15,
                                                keyboardType: TextInputType.text,
                                                style: GoogleFonts.lato(
                                                    textStyle: TextStyle(fontSize: 16)),
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.only(
                                                      left: scaler.getWidth(1),
                                                      top: scaler.getWidth(2)),
                                                  hintText: 'Aa',
                                                  counterText: '',
                                                  errorStyle: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontSize: 14
                                                      )
                                                  ),
                                                  counterStyle: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontSize: 14
                                                      )
                                                  ),
                                                  hintStyle: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                        fontSize: 16,
                                                      )),
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide:
                                                      BorderSide(color: Color(0xff6747CD))),
                                                  focusColor: Color(0xff6747CD),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide: BorderSide(
                                                          color: Color(0xff6747CD), width: 1)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide: BorderSide(
                                                          color: Color(0xff6747CD), width: 1)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                        // Number Container
                                      ],
                                    ),
                                    //Padding
                                    SizedBox(
                                      height: scaler.getWidth(1),
                                    ),],
                                ),
                              ),
                              ArrowButtom(
                                onTap: () async {
                                  await registerPersonalQuestions();
                                },
                              )
                            ],
                          ))));
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

  Future<void> registerPersonalQuestions() async {
    {
      final formState = _formKey.currentState;
      widget.userBloc = BlocProvider.of(context);
      if (formState.validate()) {
        formState.save();
        try {
          widget.userBloc.registerPersonalQuestionnaires(widget.userId, questionOne, questionTwo, questionThree);
          Navigator.push(context,MaterialPageRoute(
              builder: (context) => AdditionalDetailsPage(
                userId: widget.userId,
              )));
        } catch (e) {
          print(e.message);
          Navigator.of(context).pop();
        }
      }
      else{
        _scaffkey.currentState.showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            alignment: Alignment.center,
            child: Text(
              "Please fullfill all the fields requirements",
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
