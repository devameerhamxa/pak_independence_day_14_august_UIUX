// ignore_for_file: deprecated_member_use

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
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: provider.introFinished ? 1.0 : 0.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildControlButton(
                      onPressed: provider.nextQuote,
                      icon: Icons.format_quote,
                      label: 'New Quote',
                    ),
                    _buildControlButton(
                      onPressed: provider.toggleFireworks,
                      icon: provider.showFireworks
                          ? Icons.nightlight_round
                          : Icons.celebration,
                      label: provider.showFireworks ? 'Stop' : 'Fireworks',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildControlButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.charcoal.withOpacity(0.8),
              border: Border.all(color: AppColors.gold.withOpacity(0.5)),
            ),
            child: Icon(icon, color: AppColors.gold, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: AppColors.pakWhite.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
