// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pak_independence_day_14_august/core/theme/app_colors.dart';

class QuaidsPortrait extends StatefulWidget {
  const QuaidsPortrait({super.key});

  @override
  State<QuaidsPortrait> createState() => _QuaidsPortraitState();
}

class _QuaidsPortraitState extends State<QuaidsPortrait>
    with SingleTickerProviderStateMixin {
  late AnimationController _borderController;

  @override
  void initState() {
    super.initState();
    _borderController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _borderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Container(
          margin: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.7),
                blurRadius: 25,
                spreadRadius: 5,
              ),
            ],
          ),
          child: CustomPaint(
            painter: BorderPainter(_borderController),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.saturation,
                  ),
                  child: Image(
                    image: const AssetImage('assets/images/Leader.png'),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.person,
                        size: 100,
                        color: AppColors.pakWhite,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BorderPainter extends CustomPainter {
  final Animation<double> animation;
  BorderPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..shader = SweepGradient(
        colors: [
          AppColors.gold.withOpacity(0.8),
          AppColors.pakGreen.withOpacity(0.8),
          AppColors.gold.withOpacity(0.8),
        ],
        stops: const [0.0, 0.7, 1.0],
        transform: GradientRotation(animation.value * 2 * 3.14159),
      ).createShader(rect)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(8)),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
