import 'package:flutter/material.dart';

import '../helpers/game_controller.dart';
import '../helpers/game_screen_state.dart';
import 'game_correct_view.dart';
import 'game_playing_view.dart';
import 'game_time_up_view.dart';

/// Picks the view that matches the controller's current state.
class GameStateView extends StatelessWidget {
  final GameController controller;
  final bool isFinal;
  final VoidCallback onEnd;
  final VoidCallback onTimeUpConfirm;

  const GameStateView({
    super.key,
    required this.controller,
    required this.isFinal,
    required this.onEnd,
    required this.onTimeUpConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (_, __) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        // Expand to the full screen so a view never shrinks to its content
        // and ends up stuck in a corner.
        layoutBuilder: (current, previous) => Stack(
          fit: StackFit.expand,
          children: [...previous, if (current != null) current],
        ),
        child: _view(),
      ),
    );
  }

  Widget _view() {
    switch (controller.state) {
      case GameScreenState.playing:
        return GamePlayingView(
          team: controller.team,
          deck: controller.deck,
          remainingSeconds: controller.timer.remaining,
          onEnd: onEnd,
          onCorrect: controller.onCorrect,
          onSkip: controller.skip,
        );
      case GameScreenState.correct:
        return GameCorrectView(onNext: controller.nextAfterCorrect);
      case GameScreenState.timeUp:
        return GameTimeUpView(isFinal: isFinal, onConfirm: onTimeUpConfirm);
    }
  }
}