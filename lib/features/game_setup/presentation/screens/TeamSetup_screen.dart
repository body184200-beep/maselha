import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/appColors.dart';
import '../../../../core/widgets/appButton.dart';
import '../../data/models/team_model.dart';
import '../widgets/team_card.dart';
import '../../../game/data/sources/local_game_data_source.dart';
import '../../../game/presentation/screens/category_selection_screen.dart';

class TeamsetupScreen extends StatefulWidget {
  final int teamCount;

  const TeamsetupScreen({super.key, required this.teamCount});

  @override
  State<TeamsetupScreen> createState() => _TeamsetupScreenState();
}

class _TeamsetupScreenState extends State<TeamsetupScreen> {
  final List<Color> teamColors = [
    const Color(0xFFE53935), // Red
    const Color(0xFF1E88E5), // Blue
    const Color(0xFFFB8C00), // Orange
    const Color(0xFF8E24AA), // Purple
    const Color(0xFF43A047), // Green
    const Color(0xFF00ACC1), // Cyan
    const Color(0xFFFDD835), // Yellow
    const Color(0xFFD81B60), // Pink
  ];

  final List<TeamModel> teams = [];
  final List<TextEditingController> nameControllers = [];
  final List<TextEditingController> playerControllers = [];

  final List<String> defaultNames = [
    'الفريق الأول',
    'الفريق الثاني',
    'الفريق الثالث',
    'الفريق الرابع',
  ];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.teamCount; i++) {
      final defaultName =
          i < defaultNames.length ? defaultNames[i] : 'الفريق ${i + 1}';

      teams.add(TeamModel(
        id: 'team_$i',
        name: defaultName,
        color: teamColors[i % teamColors.length],
        players: [],
      ));

      nameControllers.add(TextEditingController(text: defaultName));
      playerControllers.add(TextEditingController());
    }
  }

  void _showWarning(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline_rounded,
                color: Colors.white, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.cairo(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void addPlayer(int teamIndex) {
    final name = playerControllers[teamIndex].text.trim();

    // Validation: Empty player name
    if (name.isEmpty) {
      _showWarning('يرجى كتابة اسم اللاعب أولاً');
      return;
    }

    // Validation: Max players reached
    if (teams[teamIndex].players.length >= 5) {
      _showWarning('الحد الأقصى لكل فريق هو 5 لاعبين');
      return;
    }

    // Validation: Duplicate player name in the same team
    final exists = teams[teamIndex]
        .players
        .any((p) => p.toLowerCase() == name.toLowerCase());
    if (exists) {
      _showWarning('اللاعب "$name" مضاف بالفعل في هذا الفريق');
      return;
    }

    setState(() {
      teams[teamIndex].players.add(name);
      playerControllers[teamIndex].clear();
    });
  }

  void deletePlayer(int teamIndex, int playerIndex) {
    setState(() {
      teams[teamIndex].players.removeAt(playerIndex);
    });
  }

  void _onContinue() {
    // 1. Sync names from controllers
    for (int i = 0; i < teams.length; i++) {
      final enteredName = nameControllers[i].text.trim();
      if (enteredName.isEmpty) {
        _showWarning('يرجى كتابة اسم لـ الفريق ${i + 1}');
        return;
      }
      teams[i].name = enteredName;
    }

    // 2. Validation: Unique team names
    final teamNamesSet = <String>{};
    for (final team in teams) {
      final normalized = team.name.toLowerCase();
      if (teamNamesSet.contains(normalized)) {
        _showWarning('يجب ألا تتكرر أسماء الفرق (الفريق "${team.name}" مكرر)');
        return;
      }
      teamNamesSet.add(normalized);
    }

    // 3. Validation: Minimum 2 players per team
    for (int i = 0; i < teams.length; i++) {
      final team = teams[i];
      if (team.players.length < 2) {
        _showWarning(
          'يجب إضافة لاعبين على الأقل في "${team.name}" (المضاف حالياً: ${team.players.length})',
        );
        return;
      }
    }

    // All validations passed -> Navigate to CategorySelectionScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategorySelectionScreen(
          teams: teams,
          dataSource: const LocalGameDataSource(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in nameControllers) {
      controller.dispose();
    }
    for (final controller in playerControllers) {
      controller.dispose();
    }
    super.dispose();
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
            'أسماء الفرق واللاعبين',
            style: GoogleFonts.cairo(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
        body: Column(
          children: [
            // Helper instruction banner
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.navy,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.25),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.primary,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'أدخل اسم كل فريق وأضف لاعبين اثنين على الأقل لكل فريق.',
                      style: GoogleFonts.cairo(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.lightGray,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Teams list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  return TeamCard(
                    teamIndex: index,
                    team: teams[index],
                    nameController: nameControllers[index],
                    playerController: playerControllers[index],
                    teamColors: teamColors,
                    onAddPlayer: () => addPlayer(index),
                    onDeletePlayer: (pIndex) => deletePlayer(index, pIndex),
                    onColorSelected: (color) {
                      setState(() {
                        teams[index].color = color;
                      });
                    },
                  );
                },
              ),
            ),

            // Next button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: AppButton(
                text: 'التالي',
                onPressed: _onContinue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
