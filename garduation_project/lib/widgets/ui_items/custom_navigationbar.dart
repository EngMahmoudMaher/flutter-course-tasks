import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:garduation_project/app%20screens/directions.dart';

class CustomNavigationBar extends StatelessWidget {
  final double widthSize;
  final double heightSize;

  const CustomNavigationBar({
    Key? key,
    required this.widthSize,
    required this.heightSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: heightSize / 5.5,
      left: widthSize / 16,
      bottom: 0,
      child: Container(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40),
              width: widthSize - 50,
              child: SvgPicture.asset(
                'assets/imag/iteams/Rect_NAV.svg',
                semanticsLabel: 'Rect_NA',
                fit: BoxFit.cover,
              ),
            ),
            //---------------- Circule of Navbar -----------------
            Positioned(
              left: (widthSize / 2.95),
              bottom: heightSize * 0.07,
              child: Container(
                width: widthSize / 5,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/imag/iteams/Group 3.png',
                      semanticLabel: 'Group 3',
                      fit: BoxFit.contain,
                    ),
                    SvgPicture.asset(
                      'assets/imag/iteams/BlutothConnectIcon.svg',
                      semanticsLabel: 'BlutothConnectIcon',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              width: widthSize - 60,
              left: widthSize * 0.01,
              bottom: heightSize * 0.08,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'HomePage');
                      },
                      child: SvgPicture.asset(
                        'assets/imag/iteams/home.svg',
                        semanticsLabel: 'home',
                        fit: BoxFit.cover,
                        width: widthSize * 0.07,
                      ),
                    ),
                    InkWell(
                      child: SvgPicture.asset(
                        'assets/imag/iteams/messages.svg',
                        semanticsLabel: 'messages',
                        fit: BoxFit.cover,
                        width: widthSize * 0.07,
                      ),
                    ),
                    SizedBox(width: widthSize * 0.2),
                    InkWell(
                      child: SvgPicture.asset(
                        'assets/imag/iteams/device-gamepad-2.svg',
                        semanticsLabel: 'device-gamepad-2',
                        fit: BoxFit.cover,
                        width: widthSize * 0.07,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ControlModeScreen(),
                          ),
                        );
                      },
                    ),
                    InkWell(
                      child: SvgPicture.asset(
                        'assets/imag/iteams/map-search.svg',
                        semanticsLabel: 'map-search',
                        fit: BoxFit.cover,
                        width: widthSize * 0.07,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
