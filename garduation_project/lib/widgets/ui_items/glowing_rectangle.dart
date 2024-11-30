import 'package:flutter/material.dart';

class GlowingRectangle extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Color innerColor;
  final Color shadowColor;

  const GlowingRectangle({
    Key? key,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.innerColor,
    required this.shadowColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: innerColor, // Rectangle color
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(borderRadius),
            bottomRight: Radius.circular(borderRadius)), // Rounded corners
        boxShadow: [
          BoxShadow(
            offset: const Offset(-5, -20),
            color: shadowColor, // Shadow color
            blurRadius: 20, // Blur intensity for the shadow
            spreadRadius: 1, // Spread of the shadow
          ),
        ],
      ),
    );
  }
}
