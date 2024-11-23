import 'package:flutter/material.dart';
import '../../widgets/buttons.dart';
import '../../widgets/google sign button.dart';
import '../../widgets/or dividor.dart';
import '../../widgets/text field.dart';
import '../sign in/sign_in_screen.dart';


class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Already have an account? ',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FullNameField(controller: _nameController),
            const SizedBox(height: 20),
            EmailField(controller: _emailController),
            const SizedBox(height: 20),
            PasswordField(controller: _passwordController),
            const SizedBox(height: 20),
            ConfirmPasswordField(
              controller: _confirmPasswordController,
              passwordController: _passwordController,
            ),
            const SizedBox(height: 20),
            SignUpButton(
              formKey: _formKey,
              emailController: _emailController,
              passwordController: _passwordController,
            ),
            const SizedBox(height: 20),
            const OrDivider(),
            const SizedBox(height: 20),
            GoogleSignUpButton(),
          ],
        ),
      ),
    );
  }
}
