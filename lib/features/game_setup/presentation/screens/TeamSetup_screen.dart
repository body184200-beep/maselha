import 'package:flutter/material.dart';

import '../../../../core/theme/appColors.dart';
import '../data/player_model.dart';
import '../widgets/team_card.dart';

class TeamsetupScreen extends StatefulWidget {
  final int teamCount;

  const TeamsetupScreen({super.key, required this.teamCount});

  @override
  State<TeamsetupScreen> createState() => _TeamsetupScreenState();
}

class _TeamsetupScreenState extends State<TeamsetupScreen> {
  final List<Color> teamColors = [
    Colors.red,
    Colors.black,
    Colors.blueAccent,
    Colors.white,
    Colors.orange,
    Colors.purple,
    Colors.green,
    Colors.yellow,
    Colors.pink,
    Colors.brown,
  ];

  final List<TeamModel> teams = [];

  final List<TextEditingController> nameControllers = [];
  final List<TextEditingController> playerControllers = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.teamCount; i++) {
      teams.add(TeamModel(name: '', color: teamColors[i], players: []));

      nameControllers.add(TextEditingController());
      playerControllers.add(TextEditingController());
    }
  }

  void addPlayer(int teamIndex) {
    final name = playerControllers[teamIndex].text.trim();

    if (name.isEmpty || teams[teamIndex].players.length >= 5) {
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
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'إعداد الفرق',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: teams.length, 
        itemBuilder: (context, index) {
          return TeamCard(
            team: teams[index],

            nameController: nameControllers[index],

            playerController: playerControllers[index],

            teamColors: teamColors,

            onAddPlayer: () {
              addPlayer(index);
            },

            onDeletePlayer: (playerIndex) {
              deletePlayer(index, playerIndex);
            },

            onColorSelected: (color) {
              setState(() {
                teams[index].color = color;
              });
            },
          );
        },
      ),
    );
  }
}
