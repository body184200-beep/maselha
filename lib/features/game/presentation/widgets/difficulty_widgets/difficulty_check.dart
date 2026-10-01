import 'package:flutter/material.dart';

import '../../../../../core/theme/appColors.dart';

class DifficultyCheck extends StatelessWidget {
  final bool isSelected;
  final Color color;

  const DifficultyCheck({
    super.key,
    required this.isSelected,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected
              ? color
              : AppColors.lightGray.withValues(alpha: 0.5),
          width: 2,
        ),
        color: isSelected ? color : Colors.transparent,
      ),
      child: isSelected
          ? const Icon(Icons.check, size: 16, color: Colors.white)
          : null,
    );
  }
}