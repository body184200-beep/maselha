import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/appColors.dart';
import '../../../../../core/widgets/appButton.dart';

import '../../helpers/game_config.dart';
import '../../helpers/game_navigation.dart';

class ResultActions extends StatelessWidget {
  final GameConfig config;

  const ResultActions({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppButton(
          text: 'لعبة جديدة بنفس الفرق',
          onPressed: () => goToRematch(context, config),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _link('تغيير الفئات والصعوبة',
                    () => goToChangeSettings(context, config)),
            _link('الرئيسية',
                    () => Navigator.of(context).popUntil((r) => r.isFirst)),
          ],
        ),
      ],
    );
  }

  Widget _link(String text, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        text,
        style: GoogleFonts.cairo(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.lightGray,
        ),
      ),
    );
  }
}