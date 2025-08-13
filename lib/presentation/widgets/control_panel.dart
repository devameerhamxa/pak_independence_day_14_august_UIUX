import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../providers/animation_provider.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AnimationProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAnimatedButton(
                    onPressed: () {
                      if (provider.isAnimating) {
                        provider.stopAnimation();
                      } else {
                        provider.startAnimation();
                      }
                    },
                    icon: provider.isAnimating ? Icons.pause : Icons.play_arrow,
                    label: provider.isAnimating ? 'Pause' : 'Animate Flag',
                    color: AppColors.pakGreen,
                  ),
                  _buildAnimatedButton(
                    onPressed: provider.toggleFireworks,
                    icon: provider.showFireworks
                        ? Icons.stop
                        : Icons.celebration,
                    label: provider.showFireworks
                        ? 'Stop Fireworks'
                        : 'Fireworks',
                    color: AppColors.gold,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAnimatedButton(
                    onPressed: provider.nextQuote,
                    icon: Icons.format_quote,
                    label: 'Next Quote',
                    color: AppColors.accent,
                  ),
                  _buildAnimatedButton(
                    onPressed: provider.resetAnimations,
                    icon: Icons.refresh,
                    label: 'Reset',
                    color: Colors.orange,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnimatedButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20),
        label: Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 4,
        ),
      ),
    );
  }
}
