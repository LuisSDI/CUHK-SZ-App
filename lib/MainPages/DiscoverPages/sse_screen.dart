import 'package:cuhkszapp/resources/major_buttom.dart';
import 'package:cuhkszapp/resources/major_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class SSEScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: scaler.getHeight(3)),
              child: Row(
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
                    height: scaler.getHeight(11),
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        '''School of Science 
and Engineering''',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //CSE Button
            Padding(
              padding: EdgeInsets.only(
                  top: scaler.getHeight(1),
                  bottom: scaler.getHeight(1),
                  left: scaler.getHeight(1.5),
                  right: scaler.getHeight(1.5)),
              child: MajorButtom(
                detail: '''Computer 
Science and 
Engineering'''
                    .trim(),
                image: "assets/images_sse_majors/CSE.png",
                alignment: Alignment(-.3, 0),
                screen: MajorScreen(
                  title: '''Computer Science 
and Engineering''',
                  pictures: [
                    "assets/images_why_screen/why_picture_2.jpg",
                    "assets/images_why_screen/why_picture_1.jpg",
                    "assets/images_why_screen/why_picture_3.jpg",
                    "assets/images_why_screen/why_picture_4.jpg",
                  ],
                  intro: '''Computer Science and Engineering is fundamental
to the information age, crossing disciplinary
boundaries and having wide application. China has 
made remarkable progress in the past decade, and 
information and communication technology has 
been central to this growth. Computers have now 
permeated all sectors and aspects of society 
and are integral to such industries as commerce,
finance, military, science and technology, 
education, media, and entertainment. Graduates 
will acquire a solid foundation in math, 
science and business, with widely applicable
knowledge and skills that will place them at 
the leading edge of their chosen fields. With 
the development of computerization, the demand 
for computer scientists will become increasingly 
prominent, especially in the Pearl River Delta 
area, where graduates with a world vision will 
be in very high demand.''',
                  schoolPackage: {
                    'BIO1001': 'General Biology',
                    'CHM1001': 'General Chemistry',
                    'CSC1001':
                        'Introduction to Computer Science: Programming Methodology',
                    'CSC1002': 'Computational Laboratory',
                    'MAT1001*': 'Calculus I',
                    'MAT1002*': 'Calculus II',
                    'MAT1003*': 'Mathematical Analysis I',
                    'MAT1004*': 'Mathematical Analysis II',
                    'MAT2040': 'Linear Algebra',
                    'PHY1001': 'Mechanics',
                    'STA2001': 'Probability and Statistics I'
                  },
                  detail:
                      '''*Students must complete either MAT 1001/1002 or MAT1003/1004.''',
                  majorReq: {
                    'CSC3001': 'Discrete Mathematics',
                    'CSC3002':
                        'Introduction to Computer Science: Programming Paradigms',
                    'CSC3050': 'Computer Architecture',
                    'CSC3100': 'Data Structures',
                    'CSC3150': 'Operating System',
                    'CSC3170': 'Database System',
                    'CSC4001': 'Software Engineering',
                    'CSC4005': 'Distributed and Parallel Computing',
                    'EIE2050': 'Digital Logic and Systems',
                    'PHY1002': 'Physics Laboratory'
                  },
                  majorElec: {
                    'BIM3001': 'Bioinformatics',
                    'CSC3180': 'Fundamentals of Artificial Intelligence',
                    'CSC3185': 'Introduction to Multimedia Systems',
                    'CSC3100': 'Data Structures',
                    'CSC3200': 'Video Games Design and Development',
                    'CSC4008': 'Techniques for Data Mining',
                    'CSC4020': 'Fundamentals of Machine Learning',
                    'CSC4120': 'Design and Analysis of Algorithms',
                    'CSC4150': 'Mobile Computing and Applications Development',
                    'CSC4160': 'Cloud Computing',
                    'CSC4170': 'Social Networks',
                    'CSC4180': 'Compiler Construction',
                    'CSC4190': 'Internet Programming and Applications',
                    'DME3004':
                        'Aesthetic and Human Values in Engineering Product Design',
                    'DME3007': 'Simulation',
                    'DME4004': 'Production Planning and Project Management',
                    'DME4006': 'Organizational Behaviour',
                    'EC02011': 'Basic Microeconomics',
                    'EIE3001': 'Signals and Systems',
                    'EIE3080': 'Microprocessors and Computer Systems',
                    'EIE3280': 'Networks: Technology, Economics and Society',
                    'EIE4001': 'Introduction to Internet Engineering',
                    'EIE4007': 'Computer and Network Security',
                    'EIE4180': 'Network Software Design and Programming',
                    'EIE4190': 'Multimedia Coding and Processing',
                    'ERG3001': 'Engineering Ethics, Safety and Practice',
                    'ERG3010': 'Data and Knowledge Management',
                    'ERG4001': 'Principles of Entrepreneurship',
                    'MAT3007': 'Optimization',
                    'MAT3220': 'Operations Research',
                    'PHY2001': 'Electricity and Magnetism',
                  },
                  studentPicture: "assets/images_students_pictures/luis.jpg",
                  studentName: 'Luis Altamirano',
                  studentCountry: 'Mexico',
                  studentOpinion: '''Lorem ipsum dolor sit amet, 
consectetur adipiscing elit, sed 
do eiusmod tempor incididunt ut 
labore et dolore magna aliqua. 
Commodo sed egestas egestas 
risus. Ut sem viverra aliquet
eget sit. Nisi scelerisque eu 
ultrices vitae.'''
                      .trim(),
                ),
              ),
            ),
            //EIE Button
            Padding(
              padding: EdgeInsets.only(
                  top: scaler.getHeight(1),
                  bottom: scaler.getHeight(1),
                  left: scaler.getHeight(1.5),
                  right: scaler.getHeight(1.5)),
              child: MajorButtom(
                detail: '''Electronic 
Information 
Engineering'''
                    .trim(),
                image: "assets/images_sse_majors/EIE.png",
              ),
            ),
            //NES Button
            Padding(
              padding: EdgeInsets.only(
                  top: scaler.getHeight(1),
                  bottom: scaler.getHeight(1),
                  left: scaler.getHeight(1.5),
                  right: scaler.getHeight(1.5)),
              child: MajorButtom(
                detail: '''New Energy 
Science and 
Engineering'''
                    .trim(),
                image: "assets/images_sse_majors/NES.png",
                alignment: Alignment(.8, 0),
              ),
            ),
            //Math Button
            Padding(
              padding: EdgeInsets.only(
                  top: scaler.getHeight(1),
                  bottom: scaler.getHeight(1),
                  left: scaler.getHeight(1.5),
                  right: scaler.getHeight(1.5)),
              child: MajorButtom(
                detail: '''Mathematics 
and Applied 
Mathematics'''
                    .trim(),
                image: 'assets/images_sse_majors/Math.png',
              ),
            ),
            //STAT Button
            Padding(
              padding: EdgeInsets.only(
                  top: scaler.getHeight(1),
                  bottom: scaler.getHeight(1),
                  left: scaler.getHeight(1.5),
                  right: scaler.getHeight(1.5)),
              child: MajorButtom(
                detail: '''Statistics'''.trim(),
                image: "assets/images_sse_majors/STAT.png",
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: scaler.getHeight(10),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff6747CD), Color(0x8C3300D6)])),
      ),
    );
  }
}
