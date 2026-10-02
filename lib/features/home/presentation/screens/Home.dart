import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/appColors.dart';
import '../../../../core/widgets/appButton.dart';
import '../../../game_setup/presentation/screens/TeamCount_screen.dart';
import '../../../suggest_word/presentation/screens/suggest_word_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void _open(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/background.jpg', fit: BoxFit.cover),
          ),
          SafeArea(
            // Align fills the screen, so the buttons are centered horizontally
            // and pinned to the bottom, on any screen size.
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppButton(
                      text: 'ابدأ اللعبة',
                      onPressed: () => _open(context, const TeamcountScreen()),
                    ),
                    TextButton(
                      onPressed: () =>
                          _open(context, const SuggestWordScreen()),
                      child: Text(
                        'اقترح كلمة',
                        style: GoogleFonts.cairo(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
