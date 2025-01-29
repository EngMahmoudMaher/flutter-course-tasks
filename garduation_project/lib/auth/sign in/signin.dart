import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:garduation_project/colors/maincolors.dart';
import 'package:garduation_project/provider/appstate.dart';
import 'package:garduation_project/widgets/ui_items/customcheckbox.dart';
import 'package:garduation_project/widgets/ui_items/customtextfield.dart';
import 'package:garduation_project/widgets/ui_items/glowing_rectangle.dart';
import 'package:garduation_project/widgets/ui_items/gradient_text.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:permission_handler/permission_handler.dart';

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
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _wheelchairController;  // Controller for the QR result
  bool _flashlightState = false;
  QrReaderViewController? _controller;
  bool _openAction = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _wheelchairController = TextEditingController();  // Initialize the controller for QR result
    _checkLoginStatus(); // Check the login status when the page is loaded
  }

  @override
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _wheelchairController.dispose();  // Dispose the controller
    _controller?.stopCamera();  // Stop the camera when the widget is disposed
    super.dispose();
  }


  // Check if the user is already logged in using SharedPreferences
  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, 'HomePage');
    }
  }

  Future<void> _saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<void> _signInWithEmailPassword() async {
    setState(() {});
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      await _saveLoginStatus(true); // Save login status
      print('User signed in: ${userCredential.user?.email}');
      Navigator.pushReplacementNamed(context, 'HomePage');
      setState(() {});
    } on FirebaseAuthException catch (e) {
      setState(() {});
      if (e.code == 'user-not-found') {
        _showErrorDialog('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        _showErrorDialog('Wrong password provided.');
      } else {
        _showErrorDialog('Error: ${e.message}');
      }
      print('FirebaseAuthException: ${e.message}');
    } catch (e) {
      setState(() {});
      print('Error signing in: $e');
      _showErrorDialog('An unexpected error occurred. Please try again later.');
    }
  }

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

  Future<void> _signInWithGoogle() async {
    setState(() {});
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        setState(() {});
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

      await _saveLoginStatus(true); // Save login status
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google Sign-in successful!')),
      );
      setState(() {});
    } catch (e) {
      setState(() {});
      print('Google Sign-In error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void alert(String tip) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(tip)));
  }

  Future<void> openScanUI(BuildContext context) async {
    // Request camera permission
    if (!await permission()) return;

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("QR Code Scanner"),
          actions: [
            IconButton(
              icon: Icon(
                _flashlightState ? Icons.flash_off : Icons.flash_on,
              ),
              onPressed: () {
                flashlight();
              },
            ),
          ],
        ),
        body: Center(
          child: QrReaderView(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            callback: (controller) {
              this._controller = controller;
              // Start camera and listen for scan results
              controller.startCamera((result, _) {
                if (!mounted) return; // Ensure widget is still mounted
                Navigator.of(context).pop(); // Close scanner
                alert(result); // Show result
                _wheelchairController.text = result;  // Update the text field with the scanned result
              });
            },
          ),
        ),
      );
    }));
  }

  // Method to toggle flashlight
  Future<void> flashlight() async {
    if (_controller == null) return; // Ensure controller is not null
    final state = await _controller?.setFlashlight();
    if (mounted) {
      setState(() {
        _flashlightState = state ?? false;
      });
    }
  }
  void handleQRCodeResult(String result) {
    if (mounted) {
      setState(() {
        _wheelchairController.text = result;  // Update the text field
      });
      Fluttertoast.showToast(msg: "QR Code Result: $result");
    }
  }

  Future<bool> permission() async {
    if (_openAction) return false;
    _openAction = true;
    var status = await Permission.camera.status;
    print(status);
    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.camera.request();
      print(status);
    }

    if (status.isRestricted) {
      alert("Restricted");
      await Future.delayed(Duration(seconds: 3));
      openAppSettings();
      _openAction = false;
      return false;
    }

    if (!status.isGranted) {
      alert("Granted");
      _openAction = false;
      return false;
    }
    _openAction = false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double WidthSize = MediaQuery.of(context).size.width;
    double HeightSize = MediaQuery.of(context).size.height;
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
                  top: HeightSize * 0.01,
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
                  top: HeightSize * 0.01,
                ),
                Positioned(
                  left: 20,
                  child: Stack(
                    children: [
                      GlowingRectangle(
                        width: WidthSize - 40,
                        height: HeightSize / 1.12,
                        bottomLeftRadius: 50,
                        bottomRightRadius: 50,
                        innerColor: Colors.white,
                        shadowColor: Colors.black.withOpacity(0.4),
                      ),
                      Positioned(
                        top: HeightSize / 35,
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
                                      appState.PasswordVisibleUpdate(
                                          !appState.isPasswordVisible);
                                    },
                                  ),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    color: ProjectColors.secondTextColor,
                                    fontSize: WidthSize / 25,
                                  ),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: HeightSize / 200),
                              CustomTextField(
                                controller: _wheelchairController,  // The updated controller for the QR result
                                hintText: 'Wheelchair ID',
                                icon: Icons.qr_code_2_outlined,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    color: ProjectColors.secondTextColor,
                                    fontSize: WidthSize / 25,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),

                              // Other UI Elements...

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
                GestureDetector(
                  onTap: () async {
                    appState.signInUpdate(true);
                    if (_formKey.currentState?.validate() ?? false) {
                      _signInWithEmailPassword();
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
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (s) {
                      return const SignUpPage();
                    }));
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
                  text: 'Sign in With',
                  size: WidthSize / 22,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF419389),
                      Color(0xFF4DF1DD)
                    ],
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
                      InkWell(
                        child: SvgPicture.asset(
                          'assets/imag/iteams/facebook_icon.svg',
                          colorFilter:
                          ColorFilter.linearToSrgbGamma(),
                        ),
                      ),
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
                      InkWell(
                        child: SvgPicture.asset(
                          'assets/imag/iteams/x_icon.svg',
                          colorFilter: ColorFilter.mode(
                              const Color.fromARGB(105, 255, 255, 255),
                              BlendMode.lighten),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.qr_code,size: 35,),
                        onPressed: () async {
                          await openScanUI(context);  // This is how you properly handle async functions in callbacks
                        },
                      ),
                    ],
                  ),
                ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
