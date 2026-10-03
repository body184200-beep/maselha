import 'package:flutter/material.dart';

import '../../../game_setup/data/models/team_model.dart';
import '../helpers/game_config.dart';
import '../helpers/tie_break.dart';
import '../widgets/draw/name_wheel.dart';
import '../widgets/draw/pick_header.dart';
import '../widgets/draw/pick_result.dart';
import '../widgets/game_shell.dart';
import 'tie_break_play_screen.dart';

/// A name wheel picks one random player for each tied team, one by one.
class TieBreakPickScreen extends StatefulWidget {
  final GameConfig config;
  final TieBreakMode mode;

  const TieBreakPickScreen({
    super.key,
    required this.config,
    required this.mode,
  });

  @override
  State<TieBreakPickScreen> createState() => _TieBreakPickScreenState();
}

class _TieBreakPickScreenState extends State<TieBreakPickScreen> {
  late final List<TeamModel> _leaders = tiedLeaders(widget.config.teams);
  final List<TieBreakParticipant> _picked = [];
  int _step = 0;
  String? _result;

  TeamModel get _team => _leaders[_step];

  bool get _isLastStep => _step == _leaders.length - 1;

  void _next() {
    _picked.add(
      TieBreakParticipant(
        teamIndex: widget.config.teams.indexOf(_team),
        player: _result!,
      ),
    );
    if (!_isLastStep) {
      setState(() {
        _step++;
        _result = null;
      });
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => TieBreakPlayScreen(
          config: widget.config,
          mode: widget.mode,
          participants: _picked,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GameShell(
      onBack: () {},
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Spacer(),
            PickHeader(
              modeLabel: widget.mode.label,
              teamName: _team.name,
              color: _team.color,
            ),
            const SizedBox(height: 24),
            NameWheel(
              key: ValueKey(_step),
              names: _team.players,
              color: _team.color,
              onResult: (i) => setState(() => _result = _team.players[i]),
            ),
            const Spacer(),
            if (_result != null)
              PickResult(
                player: _result!,
                buttonText: _isLastStep ? 'ابدأ' : 'التالي',
                onNext: _next,
              ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
