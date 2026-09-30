import 'package:flutter/material.dart';

import '../../../../core/theme/appColors.dart';

BoxDecoration teamOptionDecoration(bool isSelected) {
  return BoxDecoration(
    gradient: isSelected
        ? const LinearGradient(
      colors: [AppColors.primary, AppColors.orange],
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
    )
        : null,
    color: isSelected ? null : AppColors.navy,
    borderRadius: BorderRadius.circular(22),
    border: Border.all(
      color: isSelected
          ? Colors.white.withValues(alpha: 0.6)
          : AppColors.lightGray.withValues(alpha: 0.15),
      width: isSelected ? 2 : 1.2,
    ),
    boxShadow: [
      BoxShadow(
        color: isSelected
            ? AppColors.primary.withValues(alpha: 0.4)
            : Colors.black.withValues(alpha: 0.2),
        blurRadius: isSelected ? 18 : 10,
        offset: Offset(0, isSelected ? 6 : 4),
      ),
    ],
  );
}