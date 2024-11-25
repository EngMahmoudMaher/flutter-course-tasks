import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../app screens/home page.dart';


class SignUpButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const SignUpButton({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          try {
            // Firebase signup logic
            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );

            // Navigate to HomePage after successful signup
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()), // Replace HomePage with your actual home screen
            );

            // Optional: Show a success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sign-up successful! Welcome!')),
            );
          } on FirebaseAuthException catch (e) {
            // Handle errors
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${e.message}')),
            );
          }
        }
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.lightBlue,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
      ),
      child: const Text(
        'Sign Up',
        style: TextStyle(fontSize: 15, color: Colors.white),
      ),
    );
  }
}
