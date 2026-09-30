import 'package:flutter/material.dart';

import '../../../../core/theme/appColors.dart';

/// Selection indicator (circle with a check when selected).
class TeamOptionCheck extends StatelessWidget {
  final bool isSelected;

  const TeamOptionCheck({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColors.background : Colors.transparent,
        border: Border.all(
          color: isSelected
              ? AppColors.background
              : AppColors.lightGray.withValues(alpha: 0.4),
          width: 2,
        ),
      ),
      child: isSelected
          ? const Icon(Icons.check, size: 18, color: AppColors.primary)
          : null,
    );
  }
}