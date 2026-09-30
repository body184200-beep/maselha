import 'package:flutter/material.dart';

import '../../../../core/theme/appColors.dart';
import '../../../../core/widgets/appButton.dart';
import '../../../game/data/sources/local_game_data_source.dart';
import '../../../game/presentation/screens/category_selection_screen.dart';
import '../helpers/team_colors.dart';
import '../helpers/team_setup_controller.dart';
import '../widgets/setup_info_banner.dart';
import '../widgets/team_card.dart';
import '../widgets/team_setup_app_bar.dart';
import '../widgets/warning_snackbar.dart';

class TeamsetupScreen extends StatefulWidget {
  final int teamCount;

  const TeamsetupScreen({super.key, required this.teamCount});

  @override
  State<TeamsetupScreen> createState() => _TeamsetupScreenState();
}

class _TeamsetupScreenState extends State<TeamsetupScreen> {
  late final TeamSetupController _setup;

  @override
  void initState() {
    super.initState();
    _setup = TeamSetupController(widget.teamCount);
  }

  void _addPlayer(int teamIndex) {
    final error = _setup.addPlayer(teamIndex);
    if (error != null) return showWarning(context, error);
    setState(() {});
  }

  void _onContinue() {
    final error = _setup.validate();
    if (error != null) return showWarning(context, error);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategorySelectionScreen(
          teams: _setup.teams,
          dataSource: const LocalGameDataSource(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _setup.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const TeamSetupAppBar(),
        body: Column(
          children: [
            const SetupInfoBanner(),
            Expanded(child: _buildTeamsList()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: AppButton(text: 'التالي', onPressed: _onContinue),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamsList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      itemCount: _setup.teams.length,
      itemBuilder: (context, i) => TeamCard(
        teamIndex: i,
        team: _setup.teams[i],
        nameController: _setup.nameControllers[i],
        playerController: _setup.playerControllers[i],
        teamColors: teamColors,
        onAddPlayer: () => _addPlayer(i),
        onDeletePlayer: (p) => setState(() => _setup.deletePlayer(i, p)),
        onColorSelected: (c) => setState(() => _setup.setColor(i, c)),
      ),
    );
  }
}