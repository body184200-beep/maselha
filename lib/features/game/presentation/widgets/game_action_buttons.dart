import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/appColors.dart';

/// "صح" (green) and "التالي" (blue). When [onSkip] is null (penalty: one
/// word only) just the "صح" button is shown.
class GameActionButtons extends StatelessWidget {
  final VoidCallback onCorrect;
  final VoidCallback? onSkip;

  const GameActionButtons({
    super.key,
    required this.onCorrect,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final skip = onSkip;

    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            color: AppColors.teal,
            onPressed: onCorrect,
            child: _label('صح', 22),
          ),
        ),
        if (skip != null) ...[
          const SizedBox(width: 16),
          Expanded(
            child: _ActionButton(
              color: AppColors.secondary,
              onPressed: skip,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _label('التالي', 20),
                  const SizedBox(width: 6),
                  const Icon(Icons.arrow_forward_rounded,
                      color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  static Widget _label(String text, double size) => Text(
    text,
    style: GoogleFonts.cairo(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}

class _ActionButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;
  final Widget child;

  const _ActionButton({
    required this.color,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        child: child,
      ),
    );
  }
}