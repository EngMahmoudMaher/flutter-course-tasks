import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:garduation_project/auth/sign%20in/signin.dart';
import 'package:garduation_project/widgets/ui_items/customtextfield.dart';
import 'package:garduation_project/widgets/ui_items/glowing_rectangle.dart';
import 'package:garduation_project/widgets/ui_items/gradient_text.dart';
import '../../app screens/homepage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false; // To track the loading state
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Show success dialog with smiley face and message
  // Method to handle navigation without pop-ups
  void _navigateToHomePage() {
    Navigator.of(context).pop(); // Close any open dialogs
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void _navigateToSignInPage() {
    Navigator.of(context).pop(); // Close any open dialogs
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SigninPage()),
    );
  }

// Show success dialog with smiley face and message
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Container(
              height: 142,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GradientText(
                    text: 'Account Made',
                    size: 15,
                    gradient: LinearGradient(
                      colors: [Color(0xFF419389), Color(0xFF4DF1DD)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shadow: Shadow(
                      color: Color.fromARGB(255, 0, 0, 0),
                      blurRadius: 10.0,
                      offset: Offset(2, 2),
                    ),
                  ),
                  GradientText(
                    text: 'Successfully',
                    size: 25,
                    gradient: LinearGradient(
                      colors: [Color(0xFF419389), Color(0xFF4DF1DD)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shadow: Shadow(
                      color: Color.fromARGB(255, 0, 0, 0),
                      blurRadius: 10.0,
                      offset: Offset(2, 2),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.cyanAccent.shade200, Colors.teal.shade400],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyanAccent.shade100.withOpacity(0.5),
                          blurRadius: 20,
                          spreadRadius: 5,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: _navigateToHomePage, // Navigate after closing dialog
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

// Show error dialog when there's an issue
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Container(
              height: 140,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GradientText(
                    text: 'Account Already Signed',
                    size: 20,
                    gradient: LinearGradient(
                      colors: [Color(0xFF419389), Color(0xFF4DF1DD)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shadow: Shadow(
                      color: Color.fromARGB(255, 0, 0, 0),
                      blurRadius: 10.0,
                      offset: Offset(2, 2),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.cyanAccent.shade200, Colors.teal.shade400],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyanAccent.shade100.withOpacity(0.5),
                          blurRadius: 20,
                          spreadRadius: 5,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.do_disturb_outlined,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: _navigateToSignInPage, // Navigate after closing dialog
              child: GradientText(
                text: 'sign in ',
                size: 15,
                gradient: LinearGradient(
                  colors: [Color(0xFF419389), Color(0xFF4DF1DD)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shadow: Shadow(
                  color: Color.fromARGB(255, 0, 0, 0),
                  blurRadius: 10.0,
                  offset: Offset(2, 2),
                ),
              ),
            ),
          ],
        );
      },
    );
  }


  // Method to handle sign-up with email and password
  Future<void> _signUpWithEmailPassword() async {
    setState(() {
      _isLoading = true;
    });

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog('Passwords do not match!');
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print('User signed up: ${userCredential.user?.email}');

      // Show success dialog after successful sign-up
      _showSuccessDialog();

      setState(() {
        _isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog('Error: ${e.message}');
      print('FirebaseAuthException: ${e.message}');
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog('An unexpected error occurred.');
      print('Error signing up: $e');
    }
  }

  // Show error dialog


  @override
  Widget build(BuildContext context) {
    double WidthSize = MediaQuery.of(context).size.width;
    double HeightSize = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: WidthSize,
          height: HeightSize,
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    width: WidthSize / 3.1,
                    height: HeightSize / 1.2,
                    child: Image.asset(
                      'assets/imag/iteams/Ellipse 2.png',
                      semanticLabel: 'Ellipse 2',
                      fit: BoxFit.fill,
                    ),
                  ),
                  right: 0,
                  top: 50,
                ),
                Positioned(
                  child: Container(
                    width: WidthSize / 3.1,
                    height: HeightSize / 1.2,
                    child: Image.asset(
                      'assets/imag/iteams/Ellipse 2-1.png',
                      semanticLabel: 'Ellipse 2-1',
                      fit: BoxFit.fill,
                    ),
                  ),
                  left: 0,
                  top: 50,
                ),
                Positioned(
                  left: 20,
                  child: Stack(
                    children: [
                      GlowingRectangle(
                        width: WidthSize - 40,
                        height: HeightSize / 1.35,
                        borderRadius: 50,
                        innerColor: Colors.white,
                        shadowColor: Colors.black.withOpacity(0.4),
                      ),
                      Positioned(
                        top: HeightSize / 20,
                        left: WidthSize / 25,
                        child: Container(
                          child: Column(
                            children: [
                              InkWell(
                                child: SvgPicture.asset(
                                  'assets/imag/iteams/logo.svg',
                                  width: WidthSize / 4,
                                  height: HeightSize / 4,
                                ),
                              ),
                              SizedBox(height: HeightSize / 50),

                              // Email TextField
                              CustomTextField(
                                controller: _emailController,
                                hintText: 'Email',
                                icon: Icons.mark_email_unread_outlined,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                    return 'Enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: HeightSize / 200),

                              // Password TextField
                              CustomTextField(
                                controller: _passwordController,
                                hintText: 'Password',
                                icon: Icons.lock_person_outlined,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: HeightSize / 200),

                              // Confirm Password TextField
                              CustomTextField(
                                controller: _confirmPasswordController,
                                hintText: 'Confirm Password',
                                icon: Icons.lock_person_outlined,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your password';
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(height: HeightSize / 50),

                              // Sign Up Button
                              GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    _signUpWithEmailPassword();
                                  }
                                },
                                child: Container(
                                  width: WidthSize / 2.5,
                                  height: HeightSize / 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.cyanAccent.shade200,
                                        Colors.teal.shade400
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.cyanAccent.shade100.withOpacity(0.5),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                        offset: const Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: WidthSize / 22),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: HeightSize / 40),

                              // Sign In link
                              InkWell(
                                child: Text(
                                  'Already have an account? Sign In',
                                  style: TextStyle(
                                      fontSize: WidthSize / 30, color: Colors.cyan),
                                ),
                                onTap: () {
                                  // Navigate to SignInPage
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) =>SigninPage()),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_isLoading)
                  Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
