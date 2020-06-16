import 'package:cuhkszapp/resources/expandable_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

class FaqScreen extends StatelessWidget {
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
                        "FAQs",
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
            // Academic FAQs Text
            Padding(
              padding: EdgeInsets.only(bottom: scaler.getHeight(1)),
              child: Container(
                height: scaler.getHeight(2.5),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Academic FAQs",
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            // Q1 Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                title:
                    "1. How many majors and degrees are offered and what are they?",
                data:
                    '''For undergraduate degrees, there are four schools: School of Management and Economics, School of Science and Engineering,  School of Humanities and Social Science and School of Life and Health Sciences. With a total of 17 programmes, please go the Majors tab for more detail.''',
              ),
            ),
            //Q2 Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                title:
                    "2. Are the degrees and programmes offered the same as in the Chinese University of Hong Kong in Shatin, Hong Kong?",
                data:
                    '''CUHK Shenzhen offers modified programmes from CUHK that are adapted to the global industrial, economic, social and business environments. The quality teaching and academic research standards are consistent with CUHK, and CUHK Degrees will be awarded to CUHK-Shenzhen students who have completed the required course units and satisfy the graduation requirements of the major programme and the University.''',
              ),
            ),
            //Q3 Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                title:
                    "3. Is the language of instruction in English or bilingual with Chinese?",
                data:
                    '''We use English as our medium of learning. The language of instruction is all in English, except for Physical Education and Chinese courses, which are bilingual.''',
              ),
            ),
            //Q4 Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                title:
                    "4. Is there any option of learning Chinese after being accepted at the Chinese University of Hong Kong, Shenzhen?",
                data:
                    '''Yes. Every international student is required to take a mandatory Chinese course during their study at our University based on their Chinese language skill. Other than that, if you are interested in learning Chinese, we provide the supportive Chinese-learning environment. For instance, there are Chinese roommates, classmates, and teachers who can help you to improve your comprehension.''',
              ),
            ),
            // Campus Life  Text
            Padding(
              padding: EdgeInsets.only(bottom: scaler.getHeight(1)),
              child: Container(
                height: scaler.getHeight(2.5),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Campus Life FAQs",
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            //Q1 Campus Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                title: "1. What is the Collegiate System?",
                data:
                    '''CUHK Shenzhen offers a unique college system modeled after CUHK. The colleges are friendly communities, where every room offers a chance to meet fellow residents, make new friends, and grow together. At CUHK Shenzhen, there are four Colleges, namely Shaw, Diligentia, Harmonia and Muse. Each has their accommodations, dining halls, facilities (e.g., gym, shared kitchen, laundry, self-study rooms), and distinct characters which will quickly become your home away from home. You will be allocated to a college before arrival.

Please go to Facilities to explore more about our colleges.''',
              ),
            ),
            //Q2 Campus Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                title: "2. How easy is it to travel to and from campus?",
                data:
                    '''It is very convenient to travel to and from campus. There are bus stations just outside of campus and MTR station nearby. Another form of transportation such as Didi (Chinese version of Uber) can be easily used via a mobile phone app.''',
              ),
            ),
            //Q3 Campus Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                title:
                    "3. Where can I find any nearby entertainment or leisure activities?",
                data:
                    '''There is some number of malls and shopping centers not far from the campus. For examples, there are Coco Park, Vanke, Vanguard, Sam’s Club and Walmart. You can also take a few minutes-walk at night to find some delightful street restaurants nearby.

For more information, please go to Facilities''',
              ),
            ),
            // Admission FAQs  Text
            Padding(
              padding: EdgeInsets.only(bottom: scaler.getHeight(1)),
              child: Container(
                height: scaler.getHeight(2.5),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Admissions FAQs",
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            //Q1 Admissions Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                title: "1. How can I apply?",
                data: '''To apply for CUHK-Shenzhen 2020 Undergraduate 
Programmes, students need to prepare the following 
application documents, and then submit to the 
Online Application System in our website or apply using the Apply tab inside the application.

•  Copies of passport
•  Academic transcript(s) (legalized by the school) with the average score of all subjects for each semester
•  English test score
•  Personal statement
•  Two recommendation letters

Application Deadline: JUNE 15,2020

*Notes: Where a document is not in English, it must be accompanied by a certified English translation by a sworn translator, court translator, authorized public translator, certified translator, expert translator or an official translator. The original certificates/academic transcripts will normally be required for verification upon admission.''',
              ),
            ),
            //Q2 Admissions Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                  title: "2. What is the most crucial part of my application?",
                  data: '''
The assessment for every application is based mainly on academic and interview performance. However, there are other critical factors in determining admissions, such as English proficiency and other supporting documents.

For more information, please go to Entry Requirements.'''),
            ),
            //Q3 Admissions Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                  title:
                      "3. Can I still apply for admission if my test results have not been released?",
                  data:
                      '''Yes, you may apply with your current available documents. Then, a conditional offer will be issued if you were accepted conditionally. In order to obtain the unconditional offer, you are required to submit the remaining documents needed.'''),
            ),
            //Q4 Admissions Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                  title: "4. When is the application deadline?",
                  data:
                      '''Online application season normally starts from October to May, with a rolling-on process.'''),
            ),
            //Q5 Admissions Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                  title:
                      "5. Are the recommendation letters necessary? If yes, are there any requirements or specific format provided by the university?",
                  data:
                      '''Two recommendation letters are required for enrollment. The referee can be your school principal, counselor, or teacher as well. There aren't any specific format or requirements needed for the recommendation letters. You may send them along with the other required documents.'''),
            ),
            //Q6 Admissions Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                  title: "6. How can I send my SAT score results?",
                  data:
                      '''Our Designated Institution (DI) code is 7509. Please use this code number when sending your score reports to us.'''),
            ),
            //Q7 Admissions Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                  title:
                      "7. What if I passed my IELTS test but failed in SAT for English proficiency test? Can I still be qualified for admission?",
                  data:
                      '''Yes, you can still be qualified. Applicants only need to fulfill any one of the standards to meet our minimum English language requirement. Please go to Entry Requirements for more information.'''),
            ),
            //Q8 Admissions Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                  title: "8. Is there an interview after applying?",
                  data:
                      '''Yes, normally students are notified within 1-2 weeks after acceptance that they will have to take a 30-minute online interview. We will keep you informed of the interview schedule, please check your email for further notifications.'''),
            ),
            //Q9 Admissions Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                  title: "9. Can I apply as a transfer student?",
                  data:
                      '''You have to enter CUHK Shenzhen as a Year 1 student, studying from the first semester with the possibility of applying for credit transfer. However, the application for credit transfer should be submitted after you have been registered as a student at our University. You can also prepare the transcript from your previous University and the descriptions of the transfer modules.'''),
            ),
            //Q10 Admissions Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                  title:
                      "10. If I am a underage student, do I need a guardian in China?",
                  data:
                      '''Students under the age of 18 at the time of admission to the University have to find a guardian during his/her stay in China until he/she turns 18. An eligible guardian is an adult citizen who resides and works where the student studies (Shenzhen city).'''),
            ),
            //Q11 Admissions Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                  title:
                      "11. Will Chinese language certificates increase my chances of admission?",
                  data:
                      '''Chinese language certificate is one of the requirements for applying to the Translation programme in the School of Humanity and Social Sciences only. You may upload (if any) the certificate alongside other required documents to our Online Application System. However, international applicants are not required to submit any Chinese language proficiency certificates for the other programs.'''),
            ),
            // Fee FAQs  Text
            Padding(
              padding: EdgeInsets.only(bottom: scaler.getHeight(1)),
              child: Container(
                height: scaler.getHeight(2.5),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Fees and Scholarships FAQs",
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            //Q1 Fee Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                  title:
                      "1. How can I apply for a scholarship and what are the requirements?",
                  data:
                      '''There are no particular requirements and no separate application for entrance scholarships. You will be considered automatically for scholarships based on your academic performance, English proficiency, and interview performance.

For more information regarding scholarships, please go to Fee & Finance for more information.'''),
            ),
            //Q2 Fee Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                  title: "2. How much is the tuition fee?",
                  data:
                      '''The annual tuition fee is 95,000 RMB (approximately 14,300 USD, depends on the exchange rate). However, this can be offset or completely removed through successful scholarship application. More information can be found at Fees & Finance.'''),
            ),
            //Q3 Fee Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                  title: "3. How much is the accommodation fee?",
                  data:
                      '''The accommodation fee is 1,200 RMB per year. However, Entry Scholarships includes the accommodation fee.

'''),
            ),
            //Q4 Fee Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                  title: "4. What are the estimated living expenses per month?",
                  data:
                      '''The estimated personal living expenses (including food, electricity, transportation, entertainment, and other activities) are 2,000 RMB per month.
'''),
            ),
            //Q5 Fee Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                  title:
                      "5. Does CUHK Shenzhen offer any part-time jobs on campus?",
                  data:
                      '''Yes, we offer work-study programs on our campus, such as being a student assistant at the library, academic departments, and administrative offices. Students are paid up to 800 RMB per month.
'''),
            ),
            //Q6 Fee Expandable
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scaler.getWidth(2)),
              child: ExpansionItem(
                  title: "6. When do I have to pay the advanced tuition fee?",
                  data:
                      '''There will be a deadline to pay for the Advanced Tuition Fee after you received the Admissions Result of your application. The deadline is usually four weeks after the offer issuing date.
'''),
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
