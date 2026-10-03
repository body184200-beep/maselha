import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/appColors.dart';

/// Title above a name wheel: the tie-break mode and whose wheel it is.
class PickHeader extends StatelessWidget {
  final String modeLabel;
  final String teamName;
  final Color color;

  const PickHeader({
    super.key,
    required this.modeLabel,
    required this.teamName,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          modeLabel,
          style: GoogleFonts.cairo(fontSize: 16, color: AppColors.lightGray),
        ),
        const SizedBox(height: 8),
        Text(
          'عجلة $teamName',
          style: GoogleFonts.cairo(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}