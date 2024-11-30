import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final Shadow shadow;
  final double size;

  const GradientText({
    Key? key,
    required this.text,
    required this.gradient,
    required this.size,
    this.shadow = const Shadow(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double WidthSize = MediaQuery.of(context).size.width;
    double HeightSize = MediaQuery.of(context).size.height;
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        );
      },
      blendMode: BlendMode.srcATop,
      child: Text(
        text,
        style: TextStyle(
          fontSize: size, // Font size
          fontWeight: FontWeight.bold, // Font weight
          shadows: [
            shadow, // Add shadow effect
          ],
        ),
      ),
    );
  }
}
