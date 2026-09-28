import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/appColors.dart';
import '../../../../core/widgets/appTextField.dart';
import '../../data/models/team_model.dart';
import 'color_picker.dart';
import 'player_input.dart';

class TeamCard extends StatelessWidget {
  final int teamIndex;
  final TeamModel team;
  final TextEditingController nameController;
  final TextEditingController playerController;
  final List<Color> teamColors;
  final VoidCallback onAddPlayer;
  final Function(int) onDeletePlayer;
  final Function(Color) onColorSelected;

  const TeamCard({
    super.key,
    required this.teamIndex,
    required this.team,
    required this.nameController,
    required this.playerController,
    required this.teamColors,
    required this.onAddPlayer,
    required this.onDeletePlayer,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    final displayName = nameController.text.trim().isNotEmpty
        ? nameController.text.trim()
        : team.name.isNotEmpty
            ? team.name
            : 'الفريق ${teamIndex + 1}';

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: team.color.withValues(alpha: 0.35),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Banner with Team Color (matching Screen 3)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: team.color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.groups_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    displayName,
                    style: GoogleFonts.cairo(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Player count badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${team.players.length}/5 لاعبين',
                    style: GoogleFonts.cairo(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section: Team Name
                Text(
                  'اسم الفريق',
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightGray,
                  ),
                ),
                const SizedBox(height: 8),
                Apptextfield(
                  hintText: 'اكتب اسم الفريق (مثال: النسور)',
                  obscureText: false,
                  controller: nameController,
                  keyboardType: TextInputType.text,
                ),

                const SizedBox(height: 20),

                // Section: Color Picker
                Text(
                  'لون الفريق',
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightGray,
                  ),
                ),
                const SizedBox(height: 10),
                TeamColorPicker(
                  colors: teamColors,
                  selectedColor: team.color,
                  onColorSelected: onColorSelected,
                ),

                const SizedBox(height: 24),

                // Section: Players
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'اللاعبون',
                      style: GoogleFonts.cairo(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      'الحد الأدنى لاعبين اثنين',
                      style: GoogleFonts.cairo(
                        fontSize: 12,
                        color: team.players.length < 2
                            ? AppColors.primary
                            : AppColors.lightGray.withValues(alpha: 0.7),
                        fontWeight: team.players.length < 2
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Player Input Field
                PlayerInput(
                  controller: playerController,
                  onAdd: onAddPlayer,
                  enabled: team.players.length < 5,
                ),

                const SizedBox(height: 14),

                // Added Players List
                if (team.players.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.background.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.lightGray.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'لم يتم إضافة لاعبين بعد\n(أضف اسمين على الأقل)',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                          fontSize: 13,
                          color: AppColors.lightGray.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                  )
                else
                  Column(
                    children: team.players.asMap().entries.map((entry) {
                      final pIndex = entry.key;
                      final pName = entry.value;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.background.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: team.color.withValues(alpha: 0.25),
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: team.color,
                              child: Text(
                                '${pIndex + 1}',
                                style: GoogleFonts.cairo(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                pName,
                                style: GoogleFonts.cairo(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => onDeletePlayer(pIndex),
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.redAccent,
                                size: 20,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}