import 'package:flutter/material.dart';

import '../../../../core/theme/appColors.dart';

class ReadyIllustration extends StatelessWidget {
  final Color color;

  const ReadyIllustration({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 170,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.35), width: 3),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 30,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.person_rounded, size: 110, color: color),
          Positioned(
            top: 28,
            right: 32,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.bolt_rounded,
                size: 16,
                color: AppColors.background,
              ),
            ),
          ),
        ],
      ),
    );
  }
}