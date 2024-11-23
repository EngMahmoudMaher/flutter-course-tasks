// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double WidthSize = MediaQuery.of(context).size.width;
    double HeightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              child: Image.asset('assets/imag/Ellipse 2.png',
                  semanticLabel: 'Ellipse 2'),
              right: 0,
              top: 50,
            ),
            Positioned(
              child: Image.asset('assets/imag/Ellipse 2-1.png',
                  semanticLabel: 'Ellipse 2-1'),
              left: 0,
              top: 50,
            ),
            Positioned(
              child: Image.asset(
                'assets/imag/Rec_Main.png',
                semanticLabel: 'Rec_Main',
                fit: BoxFit.contain,
              ),
              left: 15,
              top: -30,
            ),
            Positioned(
              child: Image.asset('assets/imag/Rect_NAV.png',
                  semanticLabel: 'Rect_NAV'),
              width: WidthSize - 30,
              height: 100,
              left: 15,
              bottom: 0,
            ),
          ],
        ),
      ),
    );
  }
}