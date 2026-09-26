import 'package:flutter/material.dart';
import 'package:maselha/features/game_setup/presentation/widgets/player_input.dart';

import '../../../../core/theme/appColors.dart';
import '../../../../core/widgets/appTextField.dart';
import '../data/player_model.dart';
import 'color_picker.dart';


class TeamCard extends StatelessWidget {
  final TeamModel team;
  final TextEditingController nameController;
  final TextEditingController playerController;
  final List<Color> teamColors;
  final VoidCallback onAddPlayer;
  final Function(int) onDeletePlayer;
  final Function(Color) onColorSelected;

  const TeamCard({
    super.key,
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
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.teal,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Team Header
          Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: team.color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.groups_rounded,
                  color: team.color,
                  size: 30,
                ),
              ),

              const SizedBox(width: 16),

              Text(
                team.name.isEmpty ? 'الفريق' : team.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Team Name
          Apptextfield(
            hintText: 'اكتب اسم الفريق',
            obscureText: false,
            controller: nameController,
            keyboardType: TextInputType.text,
          ),

          const SizedBox(height: 20),

          const Text(
            'لون الفريق',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          // Colors
          TeamColorPicker(
            colors: teamColors,
            selectedColor: team.color,
            onColorSelected: onColorSelected,
          ),

          const SizedBox(height: 25),

          // Players title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'اللاعبون',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                '${team.players.length}/5',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Add Player
          PlayerInput(
            controller: playerController,
            onAdd: onAddPlayer,
            enabled: team.players.length < 5,
          ),

          const SizedBox(height: 15),

          // Players
          if (team.players.isNotEmpty)
            Column(
              children: team.players.asMap().entries.map((entry) {
                final playerIndex = entry.key;
                final playerName = entry.value;

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: team.color,
                        child: Text(
                          '${playerIndex + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          playerName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: () => onDeletePlayer(playerIndex),
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}