import 'package:flutter/material.dart';
import 'background_section.dart';
import 'sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with logo and text
          BackgroundSection(),

          // Sign-In Card, positioned in the middle with transparency
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SignInForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
