import 'package:flutter/material.dart';

import '../helpers/game_config.dart';
import '../helpers/game_controller.dart';
import '../helpers/game_navigation.dart';
import '../helpers/tie_break.dart';
import '../widgets/end_game_widgets/end_game_flow.dart';
import '../widgets/game_shell.dart';
import '../widgets/game_state_view.dart';
import '../widgets/ready_widgets/ready_content.dart';

/// One tie-break turn: a ready screen first, then the normal game views.
/// After the last picked player the result is checked again (still tied
/// means another tie-break).
class TieBreakPlayScreen extends StatefulWidget {
  final GameConfig config;
  final TieBreakMode mode;
  final List<TieBreakParticipant> participants;
  final int index;

  const TieBreakPlayScreen({
    super.key,
    required this.config,
    required this.mode,
    required this.participants,
    this.index = 0,
  });

  @override
  State<TieBreakPlayScreen> createState() => _TieBreakPlayScreenState();
}

class _TieBreakPlayScreenState extends State<TieBreakPlayScreen> {
  GameController? _controller; // created when the player presses "ready"

  TieBreakParticipant get _who => widget.participants[widget.index];
  bool get _isLast => widget.index == widget.participants.length - 1;

  void _start() => setState(() {
    _controller = createTieBreakController(
      widget.config,
      _who,
      widget.mode,
    );
  });

  void _onEnd() {
    final controller = _controller;
    if (controller != null) confirmEndGame(context, controller, widget.config);
  }

  void _finishTurn() {
    _controller?.timer.cancel();
    if (_isLast) {
      goAfterRounds(context, widget.config);
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => TieBreakPlayScreen(
          config: widget.config,
          mode: widget.mode,
          participants: widget.participants,
          index: widget.index + 1,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    return GameShell(
      onBack: _onEnd,
      child: controller == null
          ? ReadyContent(
        team: widget.config.teams[_who.teamIndex],
        actor: _who.player,
        badge: widget.mode.label,
        onStart: _start,
      )
          : GameStateView(
        controller: controller,
        isFinal: _isLast,
        onEnd: _onEnd,
        onTimeUpConfirm: _finishTurn,
      ),
    );
  }
}