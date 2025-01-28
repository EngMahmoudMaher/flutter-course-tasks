/*import 'package:flutter/material.dart';

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
*/

import 'package:flutter/material.dart';

class RotatingCircle extends StatefulWidget {
  final double size; // Diameter of the circle
  final List<Color> colors; // Gradient colors
  final double strokeWidth; // Stroke width
  final double RotatDirection;
  final int RotatSpeed;
  final bool enableGlow; // Enable or disable glow effect

  const RotatingCircle({
    Key? key,
    required this.size,
    required this.colors,
    this.strokeWidth = 8.0,
    this.RotatDirection = 1,
    this.RotatSpeed = 5,
    this.enableGlow = false, // Default is no glow
  }) : super(key: key);

  @override
  _RotatingCircleState createState() => _RotatingCircleState();
}

class _RotatingCircleState extends State<RotatingCircle>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  AnimationController? _glowController;
  Animation<double>? _glowAnimation;

  @override
  void initState() {
    super.initState();

    // Rotation animation controller
    _rotationController = AnimationController(
      duration: Duration(seconds: widget.RotatSpeed),
      vsync: this,
    )..repeat(); // Repeats the animation indefinitely

    // Glow animation controller (if enabled)
    if (widget.enableGlow) {
      _glowController = AnimationController(
        duration: const Duration(seconds: 10), // Glow duration
        vsync: this,
      )..repeat(reverse: true); // Reverse makes it increase and decrease

      _glowAnimation =
          Tween<double>(begin: 0.0, end: 40.0).animate(CurvedAnimation(
        parent: _glowController!,
        curve: Curves.bounceInOut, // Smooth increase and decrease
      ));
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _glowController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: widget.RotatDirection * (_rotationController.value * 2 * 3.14),
          child: child,
        );
      },
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: GradientCirclePainter(
          colors: widget.colors,
          strokeWidth: widget.strokeWidth,
          enableGlow: widget.enableGlow,
          glowValue: widget.enableGlow ? (_glowAnimation?.value ?? 0.0) : 0.0,
        ),
      ),
    );
  }
}

class GradientCirclePainter extends CustomPainter {
  final List<Color> colors;
  final double strokeWidth;
  final bool enableGlow;
  final double glowValue;

  GradientCirclePainter({
    required this.colors,
    this.strokeWidth = 8.0,
    this.enableGlow = false,
    this.glowValue = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;

    final paint = Paint()
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle: 3 * 3.14 / 2,
        colors: colors,
        stops: [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw the arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0.1, // Start angle
      1.5 * 3.14, // Sweep angle
      false,
      paint,
    );

    if (enableGlow) {
      // Add glow effect on the arc
      final glowPaint = Paint()
        ..shader = SweepGradient(
          startAngle: 0,
          endAngle: 3 * 3.14 / 2,
          colors: colors.map((c) => c.withOpacity(0.5)).toList(),
          stops: [0.0, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: radius))
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth * 2
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glowValue);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        0.1,
        1.5 * 3.14,
        false,
        glowPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
