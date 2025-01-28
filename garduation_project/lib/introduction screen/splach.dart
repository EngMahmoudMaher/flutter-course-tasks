import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:garduation_project/introduction%20screen/intro.dart';
import 'package:garduation_project/auth/sign%20in/signin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool hasCompletedOnboarding = false;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  // Check if the onboarding has been completed
  Future<void> _checkOnboardingStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      hasCompletedOnboarding = prefs.getBool('completedOnboarding') ?? false;
    });

    // Simulate splash screen delay (2-3 seconds)
    await Future.delayed(const Duration(seconds: 2));

    if (hasCompletedOnboarding) {
      // Navigate to SignInPage if onboarding is completed
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SigninPage()),
      );
    } else {
      // Navigate to OnBoardingPage if onboarding is not completed
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnBoardingPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double WidthSize = MediaQuery.of(context).size.width;
    double HeightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/imag/iteams/logo.svg',
          width: WidthSize / 3,
          height: HeightSize / 3,
        ),
      ),
    );
  }
}
