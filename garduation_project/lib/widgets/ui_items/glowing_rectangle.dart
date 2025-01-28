import 'package:flutter/material.dart';

class GlowingRectangle extends StatelessWidget {
  final double width;
  final double height;
  final double? topLeftRadius;
  final double? topRightRadius;
  final double? bottomLeftRadius;
  final double? bottomRightRadius;
  final Color innerColor;
  final Color shadowColor;

  const GlowingRectangle({
    Key? key,
    required this.width,
    required this.height,
    this.topLeftRadius,
    this.topRightRadius,
    this.bottomLeftRadius,
    this.bottomRightRadius,
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
          topLeft: Radius.circular(topLeftRadius ?? 0), // Default to 0 if null
          topRight: Radius.circular(topRightRadius ?? 0),
          bottomLeft: Radius.circular(bottomLeftRadius ?? 0),
          bottomRight: Radius.circular(bottomRightRadius ?? 0),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            color: shadowColor, // Shadow color
            blurRadius: 20, // Blur intensity for the shadow
            spreadRadius: 1, // Spread of the shadow
          ),
        ],
      ),
    );
  }
}
