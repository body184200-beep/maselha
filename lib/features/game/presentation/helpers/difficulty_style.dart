import 'package:flutter/material.dart';

import '../../../../core/theme/appColors.dart';

IconData difficultyIcon(String id) {
  switch (id) {
    case 'easy':
      return Icons.sentiment_satisfied_alt_rounded;
    case 'medium':
      return Icons.speed_rounded;
    case 'hard':
      return Icons.local_fire_department_rounded;
    default:
      return Icons.timer_outlined;
  }
}

Color difficultyColor(String id) {
  switch (id) {
    case 'easy':
      return AppColors.teal;
    case 'medium':
      return AppColors.primary;
    case 'hard':
      return AppColors.orange;
    default:
      return AppColors.cyan;
  }
}