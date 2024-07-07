import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'Screens/Catigory.dart';

void main() {

  runApp(Splach());}

class Splach extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,

      home:
      AnimatedSplashScreen(
          duration: 1000,

          splash: "assets/images/learning.png",
          splashIconSize: double.infinity,


          nextScreen: Category(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.leftToRightWithFade,
          backgroundColor: Colors.black),


    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(context) {
    return Container(

      color: Colors.redAccent,
    );
  }
}