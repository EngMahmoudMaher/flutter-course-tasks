import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garduation_project/colors/maincolors.dart';
import 'package:garduation_project/provider/appstate.dart';
import 'package:garduation_project/widgets/ui_items/customcheckbox.dart';
import 'package:garduation_project/widgets/ui_items/customtextfield.dart';
import 'package:garduation_project/widgets/ui_items/glowing_rectangle.dart';
import 'package:garduation_project/widgets/ui_items/gradient_text.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../app screens/homepage.dart';
import '../sign up/signup.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isLoading = false; // To track the loading state
  bool _isPasswordVisible = false; // To track password visibility

  // Sign in with email and password
  Future<void> _signInWithEmailPassword() async {
    setState(() {
      _isLoading = true;
    });
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print('User signed in: ${userCredential.user?.email}');
      // Navigate to home page or dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage()), // Replace with your HomePage
      );
      setState(() {
        _isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (e.code == 'user-not-found') {
        _showErrorDialog('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        _showErrorDialog('Wrong password provided.');
      } else if (e.code == 'too-many-requests') {
        _showErrorDialog('Too many attempts. Please try again later.');
      } else {
        _showErrorDialog('Error: ${e.message}');
      }
      print(
          'FirebaseAuthException: ${e.message}'); // Log detailed Firebase error
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error signing in: $e');
      _showErrorDialog('An unexpected error occurred. Please try again later.');
    }
  }

  // Show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign In Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Sign in with Google
  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Navigate to HomePage after successful sign-in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage()), // Replace with your HomePage
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google Sign-in successful!')),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Google Sign-In error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(); // Initialize controller
    _passwordController = TextEditingController(); // Initialize controller
  }

  @override
  void dispose() {
    _emailController.dispose(); // Clean up controller
    _passwordController.dispose(); // Clean up controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double WidthSize = MediaQuery.of(context).size.width;
    double HeightSize = MediaQuery.of(context).size.height;
    bool isChecked = false;
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: WidthSize,
          height: HeightSize,
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                //------------------------ Right Elips ------------
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
                //------------------------ Left Elips ------------
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
                //------------------------------ Rectangle ----------
                Positioned(
                  left: 20,
                  child: Stack(
                    children: [
                      GlowingRectangle(
                        width: WidthSize - 40, // Rectangle width
                        height: HeightSize / 1.35, // Rectangle height
                        borderRadius: 50, // Rounded corner radius
                        innerColor: Colors.white, // Rectangle fill color
                        shadowColor:
                            Colors.black.withOpacity(0.4), // Shadow color
                      ),
                      Positioned(
                        top: HeightSize / 20,
                        left: WidthSize / 25,
                        child: Container(
                          //decoration: BoxDecoration(border: Border.all()),
                          child: Column(
                            children: [
                              InkWell(
                                //------------ LOGO SVG ---------------
                                child: SvgPicture.asset(
                                  'assets/imag/iteams/logo.svg',
                                  width: WidthSize / 4,
                                  height: HeightSize / 4,
                                ),
                              ),
                              SizedBox(height: HeightSize / 50),
                              //------------------- TextField of Email --------------

                              CustomTextField(
                                controller: _emailController,
                                hintText: 'Email',
                                icon: Icons.mark_email_unread_outlined,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(value)) {
                                    return 'Enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: HeightSize / 200),
                              //------------------- TextField of Password --------------
                              CustomTextField(
                                controller: _passwordController,
                                hintText: 'Password',
                                icon: Icons.lock_person_outlined,
                                obscureText: !appState.isPasswordVisible,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      appState.isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: ProjectColors.secondTextColor,
                                    ),
                                    onPressed: () {
                                      //bool check = appState.isPasswordVisible;
                                      appState.PasswordVisibleUpdate(
                                          !appState.isPasswordVisible);
                                    },
                                  ),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    color: ProjectColors
                                        .secondTextColor, // Hint text color
                                    fontSize: WidthSize / 25,
                                  ),
                                  border: InputBorder
                                      .none, // Remove default underline
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),

                              //------------------- Row For Check box and pass --------------
                              Container(
                                width: WidthSize / 1.35,
                                padding: EdgeInsets.only(right: 10, left: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomCheckbox(),
                                    InkWell(
                                      child: Text(
                                        "Forget password?",
                                        style: TextStyle(
                                          color: ProjectColors.mainColor,
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              ProjectColors.mainColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: HeightSize / 50),
                              //------------------ Sign in Buttom-------------
                              GestureDetector(
                                onTap: () {
                                  appState.signInUpdate(true);
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    _signInWithEmailPassword(); // Perform email/password sign-in
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
                                        color: Colors.cyanAccent.shade100
                                            .withOpacity(0.5),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                        offset: const Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Sign in',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: WidthSize / 22),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: HeightSize / 40),
                              //------------- Create account link -----------
                              InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (s){return const SignUpPage();}));
                                },
                                child: Text(
                                  "Create New Account",
                                  style: TextStyle(
                                    color: ProjectColors.mainColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: ProjectColors.mainColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: HeightSize / 100),
                              Text(
                                "OR",
                                style: TextStyle(
                                  color: ProjectColors.mainColor,
                                ),
                              ),
                              SizedBox(height: HeightSize / 100),
                              GradientText(
                                text: 'Sign in With', // Your text
                                size: WidthSize / 22,
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF419389),
                                    Color(0xFF4DF1DD)
                                  ], // Gradient colors
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              SizedBox(height: HeightSize / 100),
                              Container(
                                width: WidthSize / 1.5,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    //------------- Facebook icon -----------
                                    InkWell(
                                      child: SvgPicture.asset(
                                        'assets/imag/iteams/facebook_icon.svg',
                                        colorFilter:
                                            ColorFilter.linearToSrgbGamma(),
                                      ),
                                    ),
                                    //------------- Google icon -----------
                                    Container(
                                      margin: EdgeInsets.only(top: 8),
                                      child: GestureDetector(
                                        onTap: _signInWithGoogle,
                                        child: SvgPicture.asset(
                                          'assets/imag/iteams/google_icon.svg',
                                          width: 32,
                                          height: 32,
                                        ),
                                      ),
                                    ),
                                    //------------- X icon -----------
                                    InkWell(
                                      child: SvgPicture.asset(
                                        'assets/imag/iteams/x_icon.svg',
                                        colorFilter: ColorFilter.mode(
                                            const Color.fromARGB(
                                                105, 255, 255, 255),
                                            BlendMode.lighten),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //---------------------------Bottom_Ellipse-----------
                Positioned(
                  child: Container(
                    width: WidthSize,
                    height: HeightSize / 10,
                    child: SvgPicture.asset(
                      'assets/imag/iteams/Bottom_Ellipse.svg',
                      semanticsLabel: 'Bottom_Ellipse',
                      fit: BoxFit.fill,
                    ),
                  ),
                  left: 0,
                  bottom: 0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
