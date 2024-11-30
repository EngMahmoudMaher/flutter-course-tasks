import 'package:flutter/material.dart';

class GlowingCircle extends StatelessWidget {
  final double size; // Diameter of the circle
  final Color innerColor; // Color of the inner circle
  final Color glowColor; // Glow color

  const GlowingCircle({
    Key? key,
    required this.size,
    required this.innerColor,
    required this.glowColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle, // Make it a circle
        color: innerColor, // Inner circle color
        boxShadow: [
          BoxShadow(
            color: glowColor, // Glow color
            blurRadius: 10, // Spread of the glow effect
            spreadRadius: 10, // Intensity of the glow
          ),
        ],
      ),
    );
  }
}
