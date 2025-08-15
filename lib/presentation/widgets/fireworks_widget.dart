// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:math' as math;

class FireworksWidget extends StatelessWidget {
  const FireworksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Firework(color: Colors.green, startX: -0.8, delay: 0),
        Firework(color: Colors.white, startX: 0.8, delay: 0.5),
        Firework(color: Colors.green, startX: -0.5, delay: 1),
        Firework(color: Colors.white, startX: 0.5, delay: 1.5),
        Firework(color: Colors.green, startX: 0.2, delay: 2),
      ],
    );
  }
}

class Firework extends StatefulWidget {
  final Color color;
  final double startX;
  final double delay;

  const Firework({
    required this.color,
    this.startX = 0.0,
    this.delay = 0.0,
    super.key,
  });

  @override
  State<Firework> createState() => _FireworkState();
}

class _FireworkState extends State<Firework> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _progress = Tween(begin: 0.0, end: 1.0).animate(_controller);

    Future.delayed(Duration(milliseconds: (widget.delay * 1000).round()), () {
      if (mounted) {
        _controller.repeat();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: FireworkPainter(
        _progress,
        color: widget.color,
        startX: widget.startX,
      ),
      size: MediaQuery.of(context).size,
    );
  }
}

class FireworkPainter extends CustomPainter {
  final Animation<double> progress;
  final Color color;
  final double startX;

  FireworkPainter(this.progress, {required this.color, required this.startX})
    : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    final val = progress.value;
    final rocketPos = Offset(
      size.width * (0.5 + startX * (1 - val)),
      size.height * (1 - val),
    );

    if (val < 0.3) {
      // Rocket trail
      final paint = Paint()
        ..color = Colors.white
        ..strokeWidth = 2;
      canvas.drawLine(Offset(rocketPos.dx, size.height), rocketPos, paint);
    } else {
      // Explosion
      final explosionProgress = (val - 0.3) / 0.7;
      final paint = Paint()
        ..color = color.withOpacity(1.0 - explosionProgress)
        ..strokeWidth = 2;

      const particleCount = 40;
      final radius = explosionProgress * 100;

      for (int i = 0; i < particleCount; i++) {
        final angle = (2 * math.pi * i) / particleCount;
        final fallOffset = Offset(0, explosionProgress * 80); // Gravity effect
        final endPos =
            rocketPos +
            Offset(radius * math.cos(angle), radius * math.sin(angle)) +
            fallOffset;
        canvas.drawCircle(endPos, 2.0 * (1.0 - explosionProgress), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
