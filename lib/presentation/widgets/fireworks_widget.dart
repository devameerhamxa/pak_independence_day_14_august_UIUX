// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:math' as math;

class FireworksWidget extends StatefulWidget {
  const FireworksWidget({super.key});

  @override
  State<FireworksWidget> createState() => _FireworksWidgetState();
}

class _FireworksWidgetState extends State<FireworksWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Firework> _fireworks;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _generateFireworks();
    _controller.repeat();
  }

  void _generateFireworks() {
    _fireworks = List.generate(8, (index) {
      return Firework(
        position: Offset(
          math.Random().nextDouble() * 400,
          math.Random().nextDouble() * 600 + 100,
        ),
        color: [
          Colors.red,
          Colors.blue,
          Colors.yellow,
          Colors.green,
        ][index % 4],
        delay: index * 0.25,
      );
    });
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
        return CustomPaint(
          painter: FireworksPainter(_fireworks, _controller.value),
          size: MediaQuery.of(context).size,
        );
      },
    );
  }
}

class Firework {
  final Offset position;
  final Color color;
  final double delay;

  Firework({required this.position, required this.color, required this.delay});
}

class FireworksPainter extends CustomPainter {
  final List<Firework> fireworks;
  final double animationValue;

  FireworksPainter(this.fireworks, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    for (final firework in fireworks) {
      final adjustedValue = (animationValue - firework.delay).clamp(0.0, 1.0);
      if (adjustedValue > 0) {
        _drawFirework(canvas, firework, adjustedValue);
      }
    }
  }

  void _drawFirework(Canvas canvas, Firework firework, double progress) {
    final paint = Paint()
      ..color = firework.color.withOpacity(1.0 - progress)
      ..strokeWidth = 2;

    const particleCount = 12;
    final radius = progress * 80;

    for (int i = 0; i < particleCount; i++) {
      final angle = (2 * math.pi * i) / particleCount;
      final endX = firework.position.dx + radius * math.cos(angle);
      final endY = firework.position.dy + radius * math.sin(angle);

      canvas.drawLine(firework.position, Offset(endX, endY), paint);

      // Draw particles at the end
      canvas.drawCircle(Offset(endX, endY), 3.0 * (1.0 - progress), paint);
    }
  }

  @override
  bool shouldRepaint(FireworksPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}
