import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/appColors.dart';

class EndGameActions extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const EndGameActions({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: shape,
              ),
              child: _label('إنهاء اللعبة'),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 48,
            child: OutlinedButton(
              onPressed: onCancel,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: AppColors.lightGray.withValues(alpha: 0.3),
                ),
                shape: shape,
              ),
              child: _label('استمرار'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _label(String text) => Text(
    text,
    style: GoogleFonts.cairo(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}