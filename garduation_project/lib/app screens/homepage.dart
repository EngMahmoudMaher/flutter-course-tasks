import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:garduation_project/app%20screens/directions.dart';
import 'package:garduation_project/utils/streamdata_from_firebase.dart';
import 'package:garduation_project/widgets/ui_items/buttongroup.dart';
import 'package:garduation_project/widgets/ui_items/glowing_circle.dart';
import 'package:garduation_project/widgets/ui_items/glowing_rectangle.dart';
import 'package:garduation_project/widgets/ui_items/gradient_text.dart';
import 'package:garduation_project/widgets/ui_items/gradientcircleanimation.dart';

bool ButtonState = false;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double WidthSize = MediaQuery.of(context).size.width;
    double HeightSize = MediaQuery.of(context).size.height;
    final circleSize = min(WidthSize, HeightSize) * 0.3;
    bool colorState = false;

    // Prevent back navigation
    return WillPopScope(
      onWillPop: () async {
        // Returning false here prevents the back navigation
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: WidthSize,
            height: HeightSize,
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
                        //---------------------- Top Icons ------------------
                        Positioned(
                          top: 20,
                          left: 10,
                          child: Row(
                            children: [
                              InkWell(
                                child: SvgPicture.asset(
                                  'assets/imag/iteams/backiconleft.svg',
                                  semanticsLabel: 'backiconleft',
                                  width: WidthSize / 30,
                                  height: HeightSize / 30,
                                ),
                              ),
                              SizedBox(width: WidthSize / 1.75),
                              InkWell(
                                child: SvgPicture.asset(
                                  'assets/imag/iteams/user-circle.svg',
                                  semanticsLabel: 'user-circle',
                                  width: WidthSize / 30,
                                  height: HeightSize / 30,
                                ),
                              ),
                              SizedBox(width: WidthSize / 25),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (j) {
                                        return ControlModeScreen();
                                      },
                                    ),
                                  );
                                },
                                child: SvgPicture.asset(
                                  'assets/imag/iteams/adjustments.svg',
                                  semanticsLabel: 'adjustments',
                                  width: WidthSize / 30,
                                  height: HeightSize / 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //--------------------- ButtonGroup -----------------
                        Positioned(
                          top: 80,
                          left: WidthSize / 12,
                          width: WidthSize / 1.2,
                          height: 40,
                          child: ButtonGroup(),
                        ),
                        //------------------------- Circules --------------------
                        Center(
                          heightFactor: HeightSize / 230,
                          widthFactor: WidthSize / 230,
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              //----------------- Arc Code -------------
                              Positioned(
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    //----------------------------  Outer Arc ------------
                                    Positioned(
                                      child: RotatingCircle(
                                        size: circleSize *
                                            1.65, // Size of the circle
                                        colors: [
                                          Color(0xFF4DF1DD),
                                          Color(0xFF419389)
                                        ], // Gradient colors
                                        strokeWidth:
                                        15.0, // Thickness of the circle
                                        RotatSpeed: 10,
                                      ),
                                    ),
                                    //---------------------------  inner Arc ------------
                                    Positioned(
                                        child: RotatingCircle(
                                          size:
                                          circleSize * 1.2, // Size of the circle
                                          colors: [
                                            Color(0xFFBEBEBE),
                                            Color(0xFF666666)
                                          ], // Gradient colors
                                          strokeWidth:
                                          10.0, // Thickness of the circle
                                          RotatDirection: -1,
                                          RotatSpeed: 5,
                                        )),
                                  ],
                                ),
                              ),
                              //----------------- Circle & Text Code -----------
                              Positioned(
                                child: Center(
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      //--------------------------- Circle ------------
                                      GlowingCircle(
                                        size: circleSize *
                                            0.9, // Circle size
                                        innerColor:
                                        Colors.white, // Inner circle color
                                        glowColor: const Color.fromARGB(
                                            88, 182, 182, 182)
                                            .withOpacity(0.5), // Outer glow color
                                      ),
                                      StreamDataFrom_Firebase()
                                    ],
                                  ),
                                ),
                              ),
                              //------------------
                            ],
                          ),
                        )
                      ],
                    )),
                //------------------- NavBar ------------
                Positioned(
                  height: HeightSize / 5.5,
                  left: WidthSize / 16,
                  bottom: 0,
                  child: Container(
                    //decoration: BoxDecoration(border: Border.all())
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 40),
                          width: WidthSize - 50,
                          child: SvgPicture.asset(
                            'assets/imag/iteams/Rect_NAV.svg',
                            semanticsLabel: 'Rect_NA',
                            fit: BoxFit.cover,
                          ),
                        ),
                        //---------------- Circule of Navbar -----------------
                        Positioned(
                          child: Container(
                            width: WidthSize / 5,
                            height: HeightSize / 5,
                            child: Image.asset(
                              'assets/imag/iteams/Group 3.png',
                              semanticLabel: 'Group 3',
                              fit: BoxFit.contain,
                            ),
                          ),
                          left: (WidthSize / 2.95),
                          bottom: 15,
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: HeightSize / 5.5,
                  left: WidthSize / 4.5,
                  child: GradientText(
                    text: ' Good State ', // Your text
                    size: WidthSize / 10,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF419389),
                        Color(0xFF4DF1DD)
                      ], // Gradient colors
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shadow: Shadow(
                      color: Color.fromARGB(255, 0, 0, 0), // Shadow color
                      blurRadius: 10.0, // Shadow blur radius
                      offset: Offset(2, 2), // Shadow offset
                    ),
                  ),
                ),
                //-------------------------------- inner Circuil and Value of Temp  ---------------------
                Positioned(
                  top: HeightSize / 1.58,
                  left: WidthSize / 16,
                  child: Container(
                    width: WidthSize - 50,
                    //decoration: BoxDecoration(border: Border.all()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          child: SvgPicture.asset(
                            'assets/imag/iteams/c.svg',
                            semanticsLabel: 'backiconleft',
                            width: WidthSize / 30,
                            height: HeightSize / 30,
                          ),
                        ),
                        // SizedBox(width: WidthSize / 5),
                        Column(
                          children: [
                            SvgPicture.asset(
                              'assets/imag/iteams/Vector 2.svg',
                              semanticsLabel: 'adjustments',
                              width: WidthSize / 30,
                              height: HeightSize / 30,
                            ),
                            SizedBox(height: 5),
                            SvgPicture.asset(
                              'assets/imag/iteams/Vector 3.svg',
                              semanticsLabel: 'adjustments',
                              width: WidthSize / 30,
                              height: HeightSize / 30,
                            ),
                          ],
                        ),
                        // SizedBox(width: WidthSize / 8),
                        InkWell(
                          child: SvgPicture.asset(
                            'assets/imag/iteams/f.svg',
                            semanticsLabel: 'adjustments',
                            width: WidthSize / 30,
                            height: HeightSize / 30,
                            color: const Color(0xffD9D9D9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
