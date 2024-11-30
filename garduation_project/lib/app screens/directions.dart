import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:garduation_project/widgets/ui_items/glowing_rectangle.dart';
import 'package:garduation_project/widgets/ui_items/gradient_text.dart';

class ControlModeScreen extends StatefulWidget {
  const ControlModeScreen({super.key});

  @override
  State<ControlModeScreen> createState() => _ControlModeScreenState();
}

class _ControlModeScreenState extends State<ControlModeScreen> {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  bool _isStraightForwardActive =
  false; // State for the "Straight Forward" button
  String _activeDirection = ""; // Tracks the currently active direction
  bool isActive = false; // Controls the active state of the button

  final List<String> _directions = [
    "Up",
    "Down",
    "Left",
    "Right",
    "Up-Left",
    "Up-Right",
    "Down-Left",
    "Down-Right"
  ];

  @override
  void initState() {
    super.initState();
    // Force the device orientation to landscape when this screen is active
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  void dispose() {
    // Restore default orientations when leaving the screen
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

  /// Updates direction based on joystick movement.
  void _updateDirection(String direction) {
    if (_isStraightForwardActive)
      return; // Ignore joystick movement when the button is active

    setState(() {
      _activeDirection = direction;
    });

    _updateFirebaseDirection();
  }

  /// Updates the Firebase database with the active direction
  void _updateFirebaseDirection() {
    final updates = <String, dynamic>{};
    for (var dir in _directions) {
      updates["Directions/$dir"] = dir == _activeDirection;
    }

    _databaseRef.update(updates).catchError((error) {
      debugPrint("Failed to update direction: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [

              //------------------------ Right Ellipse ------------
              Positioned(
                child: Container(
                  width: width / 3.1,
                  height: height / 1.2,
                  child: Image.asset(
                    'assets/imag/iteams/Ellipse 2.png',
                    semanticLabel: 'Ellipse 2',
                    fit: BoxFit.fill,
                  ),
                ),
                right: 0,
                top: 50,
              ),
              //------------------------ Left Ellipse ------------
              Positioned(
                child: Container(
                  width: width / 3.1,
                  height: height / 1.2,
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
                child: GlowingRectangle(
                  width: width - 40, // Rectangle width
                  height: height / 1.35, // Rectangle height
                  borderRadius: 50, // Rounded corner radius
                  innerColor: Colors.white, // Rectangle fill color
                  shadowColor: Colors.black.withOpacity(0.4), // Shadow color
                ),
              ),
              Positioned(
                top: height *.0025,
                left: width / 3,
                child: GradientText(
                  
                  text: ' Control Mode', // Your text
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF419389),
                      Color(0xFF4DF1DD)
                    ], // Gradient colors
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ), size: 55,
                  //
                ),
              ),
              //------------------------ Joystick -----------------
              Positioned(
                bottom: height * 0.4,
                left: width * 0.1, // Adjust joystick position
                child: Column(
                  children: [
                    Joystick(
                      includeInitialAnimation: true,

                      base: JoystickBase(
                        decoration: JoystickBaseDecoration(
                          color: Colors.grey,
                          drawOuterCircle: true,
                          middleCircleColor: Colors.transparent,
                          boxShadowColor: Colors.white,
                        ),
                        size: 150,
                      ),
                      mode: JoystickMode.all,
                      listener: (details) {
                        // Handle joystick direction here
                        String direction = "";
                        if (details.y < -0.5 && details.x.abs() < 0.5) {
                          direction = "Up";
                        } else if (details.y > 0.5 && details.x.abs() < 0.5) {
                          direction = "Down";
                        } else if (details.x < -0.5 && details.y.abs() < 0.5) {
                          direction = "Left";
                        } else if (details.x > 0.5 && details.y.abs() < 0.5) {
                          direction = "Right";
                        } else if (details.y < -0.5 && details.x < -0.5) {
                          direction = "Up-Left";
                        } else if (details.y < -0.5 && details.x > 0.5) {
                          direction = "Up-Right";
                        } else if (details.y > 0.5 && details.x < -0.5) {
                          direction = "Down-Left";
                        } else if (details.y > 0.5 && details.x > 0.5) {
                          direction = "Down-Right";
                        }

                        _updateDirection(direction);

                        // If joystick is used, disable the button (straight forward mode)
                        setState(() {
                          isActive = false; // Disable button
                          _isStraightForwardActive =
                          false; // Allow joystick control
                        });
                      },
                    ),

                  ],
                ),
              ),
              //-------------------- Straight Forward Button -----------------
              Positioned(
                bottom: height * 0.52,
                right: width * 0.32,
                child: GestureDetector(
                  onTap: () {
                    if (!isActive) {
                      setState(() {
                        // Activate button and set direction to "Up"
                        isActive = true;
                        _activeDirection = "Up"; // Set "Up" direction
                        _isStraightForwardActive = true; // Block joystick
                      });
                    } else {
                      setState(() {
                        // Deactivate the button when tapped again
                        isActive = false;
                        _isStraightForwardActive = false; // Re-enable joystick
                      });
                    }

                    _updateFirebaseDirection(); // Update Firebase with direction
                  },
                  child: Container(
                    width: 225,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: isActive
                          ? const LinearGradient(
                        colors: [Colors.cyanAccent, Colors.teal],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ) // Apply gradient when active
                          : null, // No gradient when inactive
                      border: Border.all(
                          color: Colors.grey, width: 2), // Gray border
                    ),
                    child: Center(
                      child: Text(
                        'Straight Forward',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isActive
                              ? Colors.white
                              : Colors.grey, // Text color change
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //--------------------- Direction Buttons -------------------
              Positioned(
                bottom: height * 0.4,
                left: width * 0.75, // Adjust positioning
                child: Column(
                  children: [
                    // First row: Up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [ RotatedBox(
                        quarterTurns: 5,
                        child: Container(width: 30,
                          height: 30,
                          child: Transform.rotate(
                            angle: 3.9,
                            child: CustomPaint(
                              size: Size(30, 30),
                              painter: HouseShapePainter(isDiagonal: true),
                              child: Center(
                                child: IconButton(
                                  icon: Icon(Icons.arrow_circle_left,
                                      color: Colors.black),
                                  onPressed: () {
                                    _updateDirection("Up-Left");
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                        SizedBox(width: 10,),
                        RotatedBox(
                          quarterTurns: 2,
                          child: Container(
                            width: 45,
                            height: 45,
                            child: CustomPaint(
                              size: Size(30, 30),
                              painter: HouseShapePainter(),
                              child: Center(
                                child: IconButton(
                                  icon: Icon(Icons.arrow_upward, color: Color(0xFF1ABC9C)),
                                  onPressed: () {
                                    _updateDirection("Up");
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        RotatedBox(
                          quarterTurns: 2,
                          child: Container(width: 30,
                            height: 30,
                            child: Transform.rotate(
                              angle: 3.9,
                              child: CustomPaint(
                                size: Size(30, 30),
                                painter: HouseShapePainter(isDiagonal: true),
                                child: Center(
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_circle_left,
                                        color: Colors.black),
                                    onPressed: () {
                                      _updateDirection("Up-Right");
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Second row: Up-Left, Up-Right

                    // Third row: Left, Right
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RotatedBox(
                          quarterTurns: 1,
                          child: Container(
                            width: 45,
                            height: 45,
                            child: CustomPaint(
                              size: Size(30, 30),
                              painter: HouseShapePainter(),
                              child: Center(
                                child: IconButton(
                                  icon: Icon(Icons.arrow_circle_up, color: Color(0xFF1ABC9C)),
                                  onPressed: () {
                                    _updateDirection("Left");
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 50),
                        RotatedBox(
                          quarterTurns: 3,
                          child: Container(width: 45,
                            height: 45,
                            child: CustomPaint(
                              size: Size(30, 30),
                              painter: HouseShapePainter(),
                              child: Center(
                                child: IconButton(
                                  icon: Icon(Icons.arrow_circle_left_outlined, color: Color(0xFF1ABC9C)),
                                  onPressed: () {
                                    _updateDirection("Right");
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Fourth row: Down-Left, Down-Right

                    // Fifth row: Down
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RotatedBox(
                          quarterTurns: 5,
                          child: Container(width: 30,
                            height: 30,
                            child: Transform.rotate(
                              angle: 2.4,
                              child: CustomPaint(
                                size: Size(30, 30),
                                painter: HouseShapePainter(isDiagonal: true),
                                child: Center(
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_circle_left,
                                        color: Colors.black),
                                    onPressed: () {
                                      _updateDirection("Down-Left");
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 10,),
                        Container(width: 45,
                          height: 45,
                          child: CustomPaint(
                            size: Size(30, 30),
                            painter: HouseShapePainter(),
                            child: Center(
                              child: IconButton(
                                icon: Icon(Icons.home, color: Color(0xFF1ABC9C)),
                                onPressed: () {
                                  _updateDirection("Down");
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        RotatedBox(
                          quarterTurns: 7,
                          child: Container(width: 30,
                            height: 30,
                            child: Transform.rotate(
                              angle: 3.9,
                              child: CustomPaint(
                                size: Size(30, 30),
                                painter: HouseShapePainter(isDiagonal: true),
                                child: Center(
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_circle_left,
                                        color: Colors.black),
                                    onPressed: () {
                                      _updateDirection("Down-Right");
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

              ),
              //------------------- NavBar -------------------
              Positioned(
                height: height / 5.5,
                left: width / 16,
                bottom: 0,
                child: Container(
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 40),
                        width: width - 50,
                        child: SvgPicture.asset(
                          'assets/imag/iteams/Rect_NAV.svg',
                          semanticsLabel: 'Rect_NAV',
                          fit: BoxFit.cover,
                        ),
                      ),
                      //---------------- Circular Icon -----------------
                      Positioned(
                        child: Container(
                          width: width / 5,
                          height: height / 5,
                          child: Image.asset(
                            'assets/imag/iteams/Group 3.png',
                            semanticLabel: 'Group 3',
                            fit: BoxFit.contain,
                          ),
                        ),
                        left: (width / 2.75),
                        bottom: 0.5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Direction Button widget

class HouseShapePainter extends CustomPainter {
  final bool isDiagonal;
  HouseShapePainter({this.isDiagonal = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDiagonal ? Colors.black : const Color(0xFF1ABC9C)
      ..style = PaintingStyle.fill;

    // Ensure the path is scaled to the full available size.
    final path = Path()
      ..moveTo(size.width * 0.5, 0) // Start at the top-center
      ..lineTo(size.width, size.height * 0.5) // Top-right
      ..lineTo(size.width, size.height) // Bottom-right
      ..lineTo(0, size.height) // Bottom-left
      ..lineTo(0, size.height * 0.5) // Top-left
      ..close(); // Close the path to the top-center

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}