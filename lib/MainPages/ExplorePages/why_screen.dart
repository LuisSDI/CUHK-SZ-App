import 'package:cuhkszapp/resources/expandable_tile.dart';
import 'package:cuhkszapp/resources/image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class WhyScreen extends StatelessWidget {
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
                    height: scaler.getHeight(5),
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "Why?",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 34,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Image Carousel
            ImageSlider(
              imgList: [
                "assets/images_why_screen/why_picture_2.jpg",
                "assets/images_why_screen/why_picture_1.jpg",
                "assets/images_why_screen/why_picture_3.jpg",
                "assets/images_why_screen/why_picture_4.jpg",
              ],
            ),
            //Intro Text
            Padding(
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: Container(
                height: scaler.getHeight(21),
                alignment: Alignment.topLeft,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    '''As one of the world top universities, CUHK aims
to nurture students with both specialized 
knowledge and wisdom for life. The 
CUHK-Shenzhen experience is distinguished by a 
flexible credit unit system, a unique college 
system, bilingual curricula, a rich China experience, 
and global perspectives. General education 
courses are designed to broaden students' 
perspectives and ability to face the challenges of
 the global society.'''
                        .trim(),
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 15, color: Color(0xff5A5A5B), height: 1)),
                  ),
                ),
              ),
            ),
            // Subtitle 1 Text
            Padding(
              padding: EdgeInsets.only(bottom: scaler.getHeight(1)),
              child: Container(
                height: scaler.getHeight(2.5),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Why Study in China?",
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            //China in ... Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                title: "China in “The Asian Century”",
                data: '''•   Rapidly changing, hugely diverse
•   World's second largest economy and the fastest 
      growing major economy
•   Largest exporter and second largest importer of 
      goods in the world
•   Increasing influence as a global economic power
•   Site of Asia-Pacific headquarters for numerous 
      world’s top companies''',
              ),
            ),
            //Quality of Education Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                title: "Quality of Education",
                data: '''
•   China as world leaders in many fields, including 
      engineering and business
•   Dramatic change in last 20 years in both number of 
      students and nature of education
•   Educational revolution – government expenditure 
      on education, more open range of courses for 
      international students
•   Lower living costs compared to western countries''',
              ),
            ),
            //Self-Development Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                title: "Self-development",
                data: '''
•   Language & culture programs to help learn Chinese
•   Internships and part-time work opportunities
•   Merging the knowledge of China and home 
      countries will give students an advantage to explore 
      potential opportunities in China for the future
•   World perspective as an essential part of a global 
      mindset''',
              ),
            ),
            //Travel Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                title: "Travel & Discovery",
                data: '''
•   Adventures and challenges of studying in a country 
      with a vastly different culture
•   Country with a long history,diversified terrain, 
      efficient transportation system
•   Also easy access to other countries in Asia''',
              ),
            ),
            // Subtitle 2 Text
            Padding(
              padding: EdgeInsets.only(bottom: scaler.getHeight(1)),
              child: Container(
                height: scaler.getHeight(2.5),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Why CUHK-Shenzhen?",
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            //Quality of Education 2 Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                title: "Quality of Education",
                data: '''
•   CUHK ranked 46th in the world and 10th in Asia 
      (QS World University Rankings® 2019 / 2020)
•   One Brand, Two Campuses: CUHK-Shenzhen 
      teaching and academic research standards 
      consistent with CUHK
•   Top-tier teaching staff recruited globally and an 
      internationalized academic environment
•   Programs are adapted to the global industrial, 
      economic, social and business environments
•   Fields of study that combine different disciplines,
      poised at the cutting edge of human knowledge
•   Forward-looking comprehensive research 
      university with a global vision
•   State of the art facilities''',
              ),
            ),
            //Graduation Benefits Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                title: "Graduation Benefits",
                data: '''•   CUHK degrees awarded to CUHK-Shenzhen
      students upon graduation''',
              ),
            ),
            //Whole-Person Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                title: "Whole-person Education",
                data: '''
•   Combining Chinese humanistic ideals with western 
      liberal arts content in all majors of study
•   A collegiate system which provides pastoral care
      and support throughout university
•   English as the language of instruction''',
              ),
            ),
            //Extensive Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                title: "Extensive Opportunities",
                data: '''
•   University and government scholarships covering 
      full accommodation and tuition fees
•   Shenzhen: China's Silicon Valley and headquarters 
      of numerous high-tech multinational enterprises
•   Study-aboard opportunity at some of the most 
      elite universities around the world''',
              ),
            ),
            SizedBox()
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
