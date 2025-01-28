import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:garduation_project/colors/maincolors.dart';
import 'package:garduation_project/provider/appstate.dart';
import 'package:garduation_project/utils/streamdata_from_firebase.dart';
import 'package:garduation_project/widgets/ui_items/buttongroup.dart';
import 'package:garduation_project/widgets/ui_items/custom_navigationbar.dart';
import 'package:garduation_project/widgets/ui_items/glowing_circle.dart';
import 'package:garduation_project/widgets/ui_items/glowing_rectangle.dart';
import 'package:garduation_project/widgets/ui_items/gradient_text.dart';
import 'package:garduation_project/widgets/ui_items/gradientcircleanimation.dart';
import 'package:provider/provider.dart';

bool ButtonState = false;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Color>> colorState() async {
    final appState = Provider.of<AppState>(context);
    double tempState =
        await appState.TempState; // Ensure TempState returns a non-null value
    Color color1;
    Color color2;

    if (tempState < 30) {
      color1 = Colors.blue[800]!.withOpacity(0.5);
      color2 = Colors.blue[300]!.withOpacity(0.5);
    } else if (tempState >= 30 && tempState < 40) {
      color1 = ProjectColors.mainColor.withOpacity(0.5);
      color2 = ProjectColors.secondaryColor.withOpacity(0.5);
    } else if (tempState >= 40 && tempState < 50) {
      color1 = Colors.red[800]!.withOpacity(0.5);
      color2 = Colors.red[300]!.withOpacity(0.5);
    } else {
      color1 = Colors.grey.withOpacity(0.5); // Default fallback
      color2 = Colors.grey[400]!.withOpacity(0.5);
    }

    return [color1, color2];
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    double WidthSize = MediaQuery.of(context).size.width;
    double HeightSize = MediaQuery.of(context).size.height;
    final circleSize = min(WidthSize, HeightSize) * 0.3;

    if (!appState.isTempStateReady) {
      // Show a loading indicator until the temperature data is ready
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    // Prevent back navigation
    return WillPopScope(
      onWillPop: () async {
        // Returning false here prevents the back navigation
        return false;
      },
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
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
                  top: HeightSize * 0.01,
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
                  top: HeightSize * 0.01,
                ),
                //------------------------------ Rectangle ----------
                Positioned(
                  left: 20,
                  child: Stack(
                    children: [
                      GlowingRectangle(
                        width: WidthSize - 40, // Rectangle width
                        height: HeightSize / 1.35, // Rectangle height
                        bottomLeftRadius: 30,
                        bottomRightRadius: 30,
                        innerColor: Colors.white, // Rectangle fill color
                        shadowColor:
                            Colors.black.withOpacity(0.4), // Shadow color
                      ),
                      //---------------------- Top Icons ------------------
                      Positioned(
                        top: 20,
                        left: 10,
                        child: Container(
                          //decoration: BoxDecoration(border: Border.all()),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          width: WidthSize * 0.88,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, 'userDataPage');
                                },
                                child: SvgPicture.asset(
                                  'assets/imag/iteams/user-circle.svg',
                                  semanticsLabel: 'user-circle',
                                  width: WidthSize / 25,
                                  height: HeightSize / 25,
                                ),
                              ),
                              //SizedBox(width: WidthSize / 25),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, 'SettingPage');
                                },
                                child: SvgPicture.asset(
                                  'assets/imag/iteams/adjustments.svg',
                                  semanticsLabel: 'adjustments',
                                  width: WidthSize / 25,
                                  height: HeightSize / 25,
                                ),
                              ),
                            ],
                          ),
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
                                  //----------------- Circle & Text Code -----------
                                  Positioned(
                                    child: Center(
                                      child: Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          //--------------------------- Circle ------------
                                          FutureBuilder<List<Color>>(
                                              future: colorState(),
                                              builder: (context, snapshot) {
                                                {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Center(
                                                        child: Text(
                                                            'Error: ${snapshot.error}'));
                                                  } else {
                                                    final colors =
                                                        snapshot.data!;
                                                    return GlowingCircle(
                                                        size: circleSize *
                                                            0.9, // Circle size
                                                        innerColor: Colors
                                                            .white, // Inner circle color
                                                        glowColor: colors[0]);
                                                  }
                                                }
                                              }),

                                          Container(
                                            child: appState.isTempStateReady
                                                ? StreamDataFrom_Firebase()
                                                : CircularProgressIndicator(),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
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
                                      enableGlow: false,
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

                            //------------------
                          ],
                        ),
                      )
                    ],
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

                //------------------- NavBar ------------
                CustomNavigationBar(
                    widthSize: WidthSize, heightSize: HeightSize),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
