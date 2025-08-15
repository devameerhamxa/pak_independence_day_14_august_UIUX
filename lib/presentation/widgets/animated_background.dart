// ignore_for_file: deprecated_member_use

import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/loop_animation_builder.dart';
import '../../core/theme/app_colors.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.accent,
                  AppColors.background,
                  AppColors.background,
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ),
        const Positioned.fill(child: AnimatedParticles(30)),
      ],
    );
  }
}

class AnimatedParticles extends StatefulWidget {
  final int numberOfParticles;

  const AnimatedParticles(this.numberOfParticles, {super.key});

  @override
  State<AnimatedParticles> createState() => _AnimatedParticlesState();
}

class _AnimatedParticlesState extends State<AnimatedParticles> {
  final Random random = Random();
  final List<ParticleModel> particles = [];

  @override
  void initState() {
    super.initState();
    List.generate(widget.numberOfParticles, (index) {
      particles.add(ParticleModel(random));
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoopAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(seconds: 25),
      builder: (context, value, child) {
        for (var particle in particles) {
          particle.move();
        }
        return CustomPaint(painter: ParticlePainter(particles));
      },
    );
  }
}

class ParticleModel {
  late double x, y, speed, size;
  final Random random;

  ParticleModel(this.random) {
    restart();
  }

  void restart() {
    x = random.nextDouble();
    y = 1.2;
    speed = 0.0005 + random.nextDouble() * 0.002;
    size = 0.5 + random.nextDouble() * 1.5;
  }

  void move() {
    y -= speed;
    if (y < -0.2) {
      restart();
    }
  }
}

class ParticlePainter extends CustomPainter {
  final List<ParticleModel> particles;

  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.pakWhite.withOpacity(0.2);

    for (var particle in particles) {
      final position = Offset(
        particle.x * size.width,
        particle.y * size.height,
      );
      canvas.drawCircle(position, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
