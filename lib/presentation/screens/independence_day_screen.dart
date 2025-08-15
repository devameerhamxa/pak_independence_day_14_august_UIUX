import 'package:flutter/material.dart';
import 'package:pak_independence_day_14_august/presentation/widgets/animated_background.dart';
import 'package:pak_independence_day_14_august/presentation/widgets/celebration_text.dart';
import 'package:pak_independence_day_14_august/presentation/widgets/control_panel.dart';
import 'package:pak_independence_day_14_august/presentation/widgets/fireworks_widget.dart';
import 'package:pak_independence_day_14_august/presentation/widgets/quaids_portrait.dart';
import 'package:provider/provider.dart';
import '../providers/animation_provider.dart';

class IndependenceDayScreen extends StatefulWidget {
  const IndependenceDayScreen({super.key});

  @override
  State<IndependenceDayScreen> createState() => _IndependenceDayScreenState();
}

class _IndependenceDayScreenState extends State<IndependenceDayScreen>
    with TickerProviderStateMixin {
  late AnimationController _introController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _introController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    // Start the intro animation and then mark it as finished
    _introController.forward().whenComplete(() {
      context.read<AnimationProvider>().finishIntro();
    });
  }

  @override
  void dispose() {
    _introController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AnimationProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              const AnimatedBackground(),
              if (provider.showFireworks) const FireworksWidget(),
              SafeArea(
                child: AnimatedBuilder(
                  animation: _introController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Transform.translate(
                        offset: Offset(0, _slideAnimation.value),
                        child: child,
                      ),
                    );
                  },
                  child: const Column(
                    children: [
                      Spacer(flex: 2),
                      CelebrationText(),
                      Expanded(
                        flex: 6,
                        child: QuaidsPortrait(), // New Quaid-e-Azam widget
                      ),
                      ControlPanel(),
                      Spacer(flex: 1),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
