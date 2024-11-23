import 'package:flutter/material.dart';

class FullNameField extends StatelessWidget {
  final TextEditingController controller;
  const FullNameField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: 'Full Name',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your full name';
        }
        return null; // If the name is entered, it's valid.
      },
    );
  }
}

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  const EmailField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email Address',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        // Validate the email format using a regular expression
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Enter a valid email';
        }
        return null; // If the email is valid, it's valid.
      },
    );
  }
}

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  const PasswordField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null; // If the password is valid, it's valid.
      },
    );
  }
}

class ConfirmPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController passwordController;
  const ConfirmPasswordField({
    required this.controller,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your password';
        }
        if (value != passwordController.text) {
          return 'Passwords do not match';
        }
        return null; // If passwords match, it's valid.
      },
    );
  }
}
