import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/appColors.dart';
import '../../../../../core/widgets/appButton.dart';

/// Who the wheel picked, and the button to move on.
class PickResult extends StatelessWidget {
  final String player;
  final String buttonText;
  final VoidCallback onNext;

  const PickResult({
    super.key,
    required this.player,
    required this.buttonText,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'سيمثّل: $player',
          style: GoogleFonts.cairo(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 16),
        AppButton(text: buttonText, onPressed: onNext),
      ],
    );
  }
}