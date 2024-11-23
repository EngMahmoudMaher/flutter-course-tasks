import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../app screens/home page.dart';


class GoogleSignUpButton extends StatelessWidget {
  const GoogleSignUpButton({Key? key}) : super(key: key);

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigate to HomePage after successful sign-in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), // Replace with your HomePage
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google Sign-in successful!')),
      );
    } catch (e) {
      print('Google Sign-In error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _signInWithGoogle(context),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 120),
      ),
      child: const Text('Google', style: TextStyle(fontSize: 18, color: Colors.redAccent)),
    );
  }
}
