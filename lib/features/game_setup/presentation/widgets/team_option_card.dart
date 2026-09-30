import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/appColors.dart';
import '../helpers/team_option_data.dart';
import 'team_option_check.dart';
import 'team_option_decoration.dart';

class TeamOptionCard extends StatelessWidget {
  final TeamOptionData option;
  final bool isSelected;
  final VoidCallback onTap;

  const TeamOptionCard({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: teamOptionDecoration(isSelected),
          child: Row(
            children: [
              _iconCircle(),
              const SizedBox(width: 16),
              Expanded(child: _texts()),
              TeamOptionCheck(isSelected: isSelected),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconCircle() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.background.withValues(alpha: 0.15)
            : AppColors.secondary.withValues(alpha: 0.3),
        shape: BoxShape.circle,
      ),
      child: Icon(
        option.icon,
        size: 26,
        color: isSelected ? AppColors.background : AppColors.white,
      ),
    );
  }

  Widget _texts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          option.title,
          style: GoogleFonts.cairo(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isSelected ? AppColors.background : AppColors.white,
          ),
        ),
        Text(
          option.subtitle,
          style: GoogleFonts.cairo(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isSelected
                ? AppColors.background.withValues(alpha: 0.8)
                : AppColors.lightGray,
          ),
        ),
      ],
    );
  }
}