import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../providers/animation_provider.dart';

class CelebrationText extends StatefulWidget {
  const CelebrationText({super.key});

  @override
  State<CelebrationText> createState() => _CelebrationTextState();
}

class _CelebrationTextState extends State<CelebrationText>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.5), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.bounceOut),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AnimationProvider>(
      builder: (context, provider, child) {
        return AnimatedBuilder(
          animation: Listenable.merge([_fadeAnimation, _slideAnimation]),
          builder: (context, child) {
            return SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pakistan Independence Day',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: AppColors.pakWhite,
                            shadows: [
                              const Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 4,
                                color: AppColors.pakGreen,
                              ),
                            ],
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppConstants.independenceDate,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.gold,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        AppConstants.quotes[provider.currentQuoteIndex],
                        key: ValueKey(provider.currentQuoteIndex),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.pakWhite,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
