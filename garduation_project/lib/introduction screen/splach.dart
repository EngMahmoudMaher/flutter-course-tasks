import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:garduation_project/introduction%20screen/intro.dart';

import '../auth/sign in/signin.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus(); // Check if the onboarding has been completed
  }

  // Check if the onboarding has been completed
  Future<void> _checkOnboardingStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool hasCompletedOnboarding =
        prefs.getBool('completedOnboarding') ?? false;

    // Simulate splash screen delay (3 seconds)
    Timer(const Duration(seconds: 3), () {
      if (hasCompletedOnboarding) {
        // Navigate to HomePage if onboarding is completed
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => SigninPage()), // Replace with your HomePage
        );
      } else {
        // Navigate to OnBoardingPage if onboarding is not completed
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) =>
                  const OnBoardingPage()), // Replace with your OnBoarding page
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/imag/logo/mobicare.png", // Path to your image
          fit: BoxFit.cover, // Make the image cover the full screen
        ),
      ),
    );
  }
}
