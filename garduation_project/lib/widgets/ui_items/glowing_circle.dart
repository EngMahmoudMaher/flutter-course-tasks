/*import 'package:flutter/material.dart';

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
*/

import 'package:flutter/material.dart';

class GlowingCircle extends StatefulWidget {
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
  _GlowingCircleState createState() => _GlowingCircleState();
}

class _GlowingCircleState extends State<GlowingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Animation duration
      vsync: this,
    )..repeat(reverse: true); // Reverse makes the glow increase and decrease

    // Define the glow animation
    _glowAnimation = Tween<double>(begin: 0.0, end: 40.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle, // Make it a circle
            color: widget.innerColor, // Inner circle color
            boxShadow: [
              BoxShadow(
                color: widget.glowColor, // Glow color
                blurRadius: _glowAnimation.value, // Dynamic blur radius
                spreadRadius: _glowAnimation.value * 2, // Dynamic spread radius
              ),
            ],
          ),
        );
      },
    );
  }
}
