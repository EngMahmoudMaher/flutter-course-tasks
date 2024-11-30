import 'package:flutter/material.dart';

class RotatingCircle extends StatefulWidget {
  final double size; // Diameter of the circle
  final List<Color> colors; // Gradient colors
  final double strokeWidth; // Stroke width
  final double RotatDirection;
  final int RotatSpeed;

  const RotatingCircle({
    Key? key,
    required this.size,
    required this.colors,
    this.strokeWidth = 8.0,
    this.RotatDirection = 1,
    this.RotatSpeed = 5,
  }) : super(key: key);

  @override
  _RotatingCircleState createState() => _RotatingCircleState();
}

class _RotatingCircleState extends State<RotatingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: widget.RotatSpeed), // Rotation duration
      vsync: this,
    )..repeat(); // Repeats the animation indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: widget.RotatDirection *
              (_controller.value * 2 * 3.14), // Rotates 360 degrees
          child: child,
        );
      },
      child: CustomPaint(
        size: Size(widget.size, widget.size), // Circle size
        painter: GradientCirclePainter(
            colors: widget.colors, strokeWidth: widget.strokeWidth),
      ),
    );
  }
}

class GradientCirclePainter extends CustomPainter {
  final List<Color> colors;
  final double strokeWidth;

  GradientCirclePainter({
    required this.colors,
    this.strokeWidth = 8.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle: 3 * 3.14 / 2, // Slightly less than a full circle
        colors: colors,
        stops: [0.0, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round; // Rounded ends of the circle

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0.1, // Start angle
      1.5 * 3.14, // Sweep angle (about 270 degrees)
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
