import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/appColors.dart';
import '../../../../core/widgets/appButton.dart';

// Screen 10: time is up
class GameTimeUpView extends StatelessWidget {
  final bool isFinal;
  final VoidCallback onConfirm;

  const GameTimeUpView({
    super.key,
    required this.isFinal,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Spacer(flex: 1),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.secondary.withValues(alpha: 0.4),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.secondary.withValues(alpha: 0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.hourglass_empty_rounded,
              size: 54,
              color: AppColors.lightGray,
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'انتهى الوقت!',
            style: GoogleFonts.cairo(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isFinal
                ? 'اكتملت جميع الجولات!'
                : 'تبديل الدور إلى الفريق التالي',
            style: GoogleFonts.cairo(fontSize: 16, color: AppColors.lightGray),
          ),
          const Spacer(flex: 2),
          AppButton(text: 'حسناً', onPressed: onConfirm),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}