import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../providers/animation_provider.dart';

class FlagWidget extends StatefulWidget {
  const FlagWidget({super.key});

  @override
  State<FlagWidget> createState() => _FlagWidgetState();
}

class _FlagWidgetState extends State<FlagWidget> with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _scaleController;
  late Animation<double> _waveAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _waveController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _waveAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _scaleController.forward();
  }

  @override
  void dispose() {
    _waveController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AnimationProvider>(
      builder: (context, provider, child) {
        if (provider.isAnimating && !_waveController.isAnimating) {
          _waveController.repeat();
        } else if (!provider.isAnimating) {
          _waveController.stop();
        }

        return AnimatedBuilder(
          animation: Listenable.merge([_waveAnimation, _scaleAnimation]),
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CustomPaint(
                    painter: FlagPainter(_waveAnimation.value),
                    size: const Size(300, 200),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class FlagPainter extends CustomPainter {
  final double wavePhase;

  FlagPainter(this.wavePhase);

  @override
  void paint(Canvas canvas, Size size) {
    final greenPaint = Paint()..color = AppColors.pakGreen;
    final whitePaint = Paint()..color = AppColors.pakWhite;
    final starPaint = Paint()
      ..color = AppColors.pakWhite
      ..style = PaintingStyle.fill;
    final moonPaint = Paint()
      ..color = AppColors.pakWhite
      ..style = PaintingStyle.fill;

    // Draw white stripe (left side)
    final whitePath = Path();
    for (int i = 0; i <= size.height.toInt(); i++) {
      double waveOffset =
          10 *
          math.sin((i / size.height) * 4 * math.pi + wavePhase * 2 * math.pi);
      if (i == 0) {
        whitePath.moveTo(0, i.toDouble());
      } else {
        whitePath.lineTo(size.width * 0.25 + waveOffset, i.toDouble());
      }
    }
    whitePath.lineTo(0, size.height);
    whitePath.close();
    canvas.drawPath(whitePath, whitePaint);

    // Draw green stripe (right side)
    final greenPath = Path();
    for (int i = 0; i <= size.height.toInt(); i++) {
      double waveOffset =
          10 *
          math.sin((i / size.height) * 4 * math.pi + wavePhase * 2 * math.pi);
      if (i == 0) {
        greenPath.moveTo(size.width * 0.25 + waveOffset, i.toDouble());
      } else {
        greenPath.lineTo(size.width * 0.25 + waveOffset, i.toDouble());
      }
    }
    greenPath.lineTo(size.width, size.height);
    greenPath.lineTo(size.width, 0);
    greenPath.close();
    canvas.drawPath(greenPath, greenPaint);

    // Draw crescent moon
    final center = Offset(size.width * 0.625, size.height * 0.5);
    final moonRadius = size.width * 0.08;

    canvas.drawCircle(center, moonRadius, moonPaint);
    canvas.drawCircle(
      Offset(center.dx + moonRadius * 0.3, center.dy - moonRadius * 0.1),
      moonRadius * 0.8,
      greenPaint,
    );

    // Draw star
    final starCenter = Offset(size.width * 0.75, size.height * 0.5);
    final starRadius = size.width * 0.04;
    _drawStar(canvas, starCenter, starRadius, starPaint);
  }

  void _drawStar(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    const int points = 5;
    const double angle = math.pi / points;

    for (int i = 0; i < points * 2; i++) {
      final double r = (i % 2 == 0) ? radius : radius * 0.5;
      final double x = center.dx + r * math.cos(i * angle - math.pi / 2);
      final double y = center.dy + r * math.sin(i * angle - math.pi / 2);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(FlagPainter oldDelegate) =>
      oldDelegate.wavePhase != wavePhase;
}
