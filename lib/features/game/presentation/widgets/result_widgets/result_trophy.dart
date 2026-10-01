import 'package:flutter/material.dart';

import '../../../../../core/theme/appColors.dart';

class ResultTrophy extends StatelessWidget {
  const ResultTrophy({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.35),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35),
            blurRadius: 36,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Icon(
        Icons.emoji_events_rounded,
        size: 64,
        color: AppColors.primary,
      ),
    );
  }
}