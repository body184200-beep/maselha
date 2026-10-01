import 'package:flutter/material.dart';

import '../../helpers/game_config.dart';
import '../../helpers/game_controller.dart';
import '../../helpers/game_navigation.dart';
import 'end_game_dialog.dart';

/// Freezes the clock, asks both teams to confirm, then ends or resumes.
void confirmEndGame(
    BuildContext context,
    GameController controller,
    GameConfig config,
    ) {
  controller.pause();
  showEndGameDialog(
    context,
    config.teams,
    onConfirm: () {
      controller.timer.cancel();
      goToResult(context, config);
    },
    onCancel: controller.resume,
  );
}