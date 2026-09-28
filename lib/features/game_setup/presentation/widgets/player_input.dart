import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/appColors.dart';
import '../../../../core/widgets/appTextField.dart';

class PlayerInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAdd;
  final bool enabled;

  const PlayerInput({
    super.key,
    required this.controller,
    required this.onAdd,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Apptextfield(
            hintText: enabled ? 'اكتب اسم اللاعب...' : 'اكتمل عدد اللاعبين',
            obscureText: false,
            controller: controller,
            keyboardType: TextInputType.text,
            onSubmitted: enabled ? (_) => onAdd() : null,
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: enabled ? onAdd : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.background,
              disabledBackgroundColor: AppColors.lightGray.withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.add_rounded, size: 20),
                const SizedBox(width: 4),
                Text(
                  'إضافة',
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}