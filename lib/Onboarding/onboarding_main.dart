import 'package:cuhkszapp/Login/sign_in_page.dart';
import 'package:cuhkszapp/resources/page_index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data_onbording.dart';
import 'onboarding_screens.dart';

class OnboardingMain extends StatefulWidget {
  @override
  _OnboardingMainState createState() => _OnboardingMainState();
}

class _OnboardingMainState extends State<OnboardingMain> {

  List<SliderModel> slides = new List<SliderModel>();
  int currentIndex = 0;
  PageController pageController = new PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slides = getSlides();
  }

  @override
  Widget build(BuildContext context) {
    double block_horizontal = MediaQuery
        .of(context)
        .size
        .width / 15;
    double block_vertical = MediaQuery
        .of(context)
        .size
        .height / 32.5;
    return Container(
        child: Scaffold(
          body: PageView.builder(
              controller: pageController,
              itemCount: slides.length,
              onPageChanged: (val) {
                setState(() {
                  currentIndex = val;
                });
              },
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    OnboardingScreen(
                      imageAssetPath: slides[index].getImageAssetPath(),
                      title: slides[index].getTitle(),
                      desc: slides[index].getDesc(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for(int i = 0; i < slides.length; i++ ) currentIndex ==
                            i ? PageIndex(true) : PageIndex(false)
                      ],),
                    GestureDetector(
                      onTap: () {
                        if ( currentIndex == slides.length - 1){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage()),);
                        }
                        else{
                        pageController.animateToPage(currentIndex + 1,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.linear);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: block_vertical * 1.5
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(block_horizontal * .6),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(currentIndex == slides.length - 1 ?
                            "Let's Start" : "Next",
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white
                                  )
                              ),

                            ),
                          ),
                        ),
                        width: block_horizontal * 10,
                        height: block_vertical * 2.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xff6747CD),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 4.0,
                              // soften the shadow//extend the shadow
                              offset: Offset(
                                0,
                                6,
                              ),
                            )
                          ],


                        ),

                      ),
                    )
                  ],
                );
              }),
        )
    );
  }
}