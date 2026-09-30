import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/appColors.dart';
import '../../../../core/widgets/appButton.dart';
import '../helpers/team_option_data.dart';
import '../widgets/team_count_header.dart';
import '../widgets/team_option_card.dart';
import 'teamsetup_screen.dart';

class TeamcountScreen extends StatefulWidget {
  const TeamcountScreen({super.key});

  @override
  State<TeamcountScreen> createState() => _TeamcountScreenState();
}

class _TeamcountScreenState extends State<TeamcountScreen> {
  int _selectedCount = 2;

  void _onNext() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TeamsetupScreen(teamCount: _selectedCount),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.white),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Text(
            'إعداد اللعبة',
            style: GoogleFonts.cairo(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.lightGray,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              children: [
                const SizedBox(height: 12),
                const TeamCountHeader(),
                const Spacer(flex: 1),
                for (final option in teamOptions)
                  TeamOptionCard(
                    option: option,
                    isSelected: _selectedCount == option.count,
                    onTap: () => setState(() => _selectedCount = option.count),
                  ),
                const Spacer(flex: 2),
                AppButton(text: 'التالي', onPressed: _onNext),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}