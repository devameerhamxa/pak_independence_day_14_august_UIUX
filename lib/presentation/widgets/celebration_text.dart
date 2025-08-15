// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../providers/animation_provider.dart';

class CelebrationText extends StatelessWidget {
  const CelebrationText({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Consumer<AnimationProvider>(
      builder: (context, provider, child) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 800),
          opacity: provider.introFinished ? 1.0 : 0.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppConstants.celebrationMessage,
                style: textTheme.displayLarge?.copyWith(
                  color: AppColors.gold,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                AppConstants.independenceDate,
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColors.pakWhite.withOpacity(0.7),
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 24),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.5),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    AppConstants.quotes[provider.currentQuoteIndex],
                    key: ValueKey(provider.currentQuoteIndex),
                    style: textTheme.bodyLarge?.copyWith(
                      color: AppColors.pakWhite,
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
