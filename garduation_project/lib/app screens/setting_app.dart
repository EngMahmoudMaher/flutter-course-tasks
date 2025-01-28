import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:garduation_project/colors/maincolors.dart';
import 'package:garduation_project/provider/appstate.dart';
import 'package:garduation_project/widgets/ui_items/glowing_rectangle.dart';
import 'package:provider/provider.dart';

bool ButtonState = false;

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

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
                        bottomLeftRadius: 50,
                        bottomRightRadius: 50,
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
                          width: WidthSize * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, 'HomePage');
                                },
                                child: SvgPicture.asset(
                                  'assets/imag/iteams/backiconleft.svg',
                                  semanticsLabel: 'backiconleft',
                                  width: WidthSize / 20,
                                  height: HeightSize / 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //------------------------------ Content Of Rectangle ------------------------
                      Container(
                        width: WidthSize - 40,
                        height: HeightSize / 1.35,
                        //decoration: BoxDecoration(border: Border.all()),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () async {
                                  await Provider.of<authProvider>(context,
                                          listen: false)
                                      .logout();
                                  Navigator.pushNamed(context, 'SigninPage');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.settings_backup_restore_rounded,
                                      color: ProjectColors.mainColor,
                                      size: WidthSize / 15,
                                    ),
                                    Text(
                                      'LogOut',
                                      style: TextStyle(
                                        color: ProjectColors.mainColor,
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            ProjectColors.mainColor,
                                        fontSize: WidthSize / 20,
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      )
                    ],
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
