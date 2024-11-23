import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app screens/home page.dart'; // Your HomePage
import '../auth/sign in/sign in.dart'; // Your SignIn page

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  // To persist the onboarding completion state
  Future<void> _completeOnboarding(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('completedOnboarding', true); // Mark onboarding as complete

    // Navigate to HomePage (or SignIn page based on your flow)
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => SignIn()), // Or SignIn page if applicable
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/imag/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 6000,
      infiniteAutoScroll: true,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: _buildImage('wc4.png', 100),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Automatic Driving Wheel Chair",
          body: "The Automatic Driving Wheelchair is a cutting-edge mobility solution designed to provide independence, safety, and comfort for individuals with mobility challenges.",
          image: _buildImage('gf.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Eye Tracking",
          body: "Enables individuals with limited mobility to control devices, communicate, and interact with their surroundings through eye movement alone.",
          image: _buildImage('wc3.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Remote Control",
          body: "Mobile app for assistive technology can empower users with features like eye-tracking control, health monitoring, voice commands, and navigation support, enhancing independence and accessibility.",
          image: _buildImage('wc1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Voice Control",
          body: "Voice control offers a hands-free, intuitive way for users to interact with devices, providing greater accessibility and convenience.",
          image: _buildImage('wc2.png'),
          decoration: pageDecoration.copyWith(
            bodyFlex: 6,
            imageFlex: 6,
            safeArea: 80,
          ),
        ),
        PageViewModel(
          title: "Welcome to our App!",
          bodyWidget: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 4,
            bodyAlignment: Alignment.center,
            contentMargin: const EdgeInsets.only(left: 16, right: 16),
            titleTextStyle: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            bodyTextStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('wc3.png'),
          reverse: true,
        ),
      ],
      onDone: () => _completeOnboarding(context), // OnDone, mark onboarding as complete
      onSkip: () => _completeOnboarding(context), // OnSkip, mark onboarding as complete
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      back: const Icon(Icons.arrow_back, color: Colors.white),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white)),
      next: const Icon(Icons.arrow_forward, color: Colors.white),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.deepPurpleAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
      ),
    );
  }
}
