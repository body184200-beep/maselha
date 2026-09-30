import 'package:flutter/material.dart';

import '../../../../core/theme/appColors.dart';

/// Top icon with a glowing background ring.
class TeamCountIcon extends StatelessWidget {
  const TeamCountIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: AppColors.secondary.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.secondary.withValues(alpha: 0.25),
                blurRadius: 30,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
        Container(
          width: 76,
          height: 76,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.secondary, AppColors.navy],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.cyan.withValues(alpha: 0.5),
              width: 2,
            ),
          ),
          child: const Icon(
            Icons.groups_rounded,
            size: 40,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}