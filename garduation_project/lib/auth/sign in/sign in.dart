import 'package:flutter/material.dart';
import 'sign_in_screen.dart';
void main() {
  runApp(SignIn());
}
class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}
