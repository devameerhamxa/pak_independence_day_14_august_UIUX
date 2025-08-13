import 'package:flutter/material.dart';
import 'package:pak_independence_day_14_august/presentation/widgets/animated_background.dart';
import 'package:pak_independence_day_14_august/presentation/widgets/celebration_text.dart';
import 'package:pak_independence_day_14_august/presentation/widgets/control_panel.dart';
import 'package:pak_independence_day_14_august/presentation/widgets/fireworks_widget.dart';
import 'package:pak_independence_day_14_august/presentation/widgets/flag_widget.dart';
import 'package:provider/provider.dart';
import '../providers/animation_provider.dart';

class IndependenceDayScreen extends StatelessWidget {
  const IndependenceDayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AnimationProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              const AnimatedBackground(),
              const SafeArea(
                child: Column(
                  children: [
                    Expanded(flex: 2, child: CelebrationText()),
                    Expanded(flex: 4, child: Center(child: FlagWidget())),
                    Expanded(flex: 2, child: ControlPanel()),
                  ],
                ),
              ),
              if (provider.showFireworks) const FireworksWidget(),
            ],
          );
        },
      ),
    );
  }
}
