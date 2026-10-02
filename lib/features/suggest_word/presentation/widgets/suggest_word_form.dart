import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/appColors.dart';
import '../../../../core/widgets/appButton.dart';
import '../../data/word_category.dart';
import 'category_chips.dart';

class SuggestWordForm extends StatelessWidget {
  final List<WordCategory> categories;
  final int? selectedId;
  final ValueChanged<int> onSelect;
  final TextEditingController controller;
  final bool sending;
  final VoidCallback onSubmit;

  const SuggestWordForm({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onSelect,
    required this.controller,
    required this.sending,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _label('اختر الفئة'),
        const SizedBox(height: 12),
        CategoryChips(
          categories: categories,
          selectedId: selectedId,
          onSelect: onSelect,
        ),
        const SizedBox(height: 28),
        _label('الكلمة المقترحة'),
        const SizedBox(height: 12),
        TextField(
          controller: controller,
          style: GoogleFonts.cairo(color: AppColors.white, fontSize: 18),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.navy,
            hintText: 'اكتب الكلمة هنا',
            hintStyle: GoogleFonts.cairo(color: AppColors.lightGray),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Opacity(
          opacity: sending ? 0.5 : 1,
          child: AppButton(
            text: sending ? 'جاري الإرسال...' : 'إرسال',
            onPressed: () {
              if (!sending) onSubmit();
            },
          ),
        ),
      ],
    );
  }

  Widget _label(String text) => Text(
    text,
    style: GoogleFonts.cairo(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.white,
    ),
  );
}