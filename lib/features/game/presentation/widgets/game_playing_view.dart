import 'package:flutter/material.dart';

import '../../../game_setup/data/models/team_model.dart';
import '../helpers/word_deck.dart';
import 'game_action_buttons.dart';
import 'game_actor_badge.dart';
import 'game_top_bar.dart';
import 'game_word_card.dart';

// Screens 7 & 9: word display / new word
class GamePlayingView extends StatelessWidget {
  final TeamModel team;
  final WordDeck deck;
  final int remainingSeconds;
  final VoidCallback onEnd;
  final VoidCallback onCorrect;
  final VoidCallback onSkip;

  const GamePlayingView({
    super.key,
    required this.team,
    required this.deck,
    required this.remainingSeconds,
    required this.onEnd,
    required this.onCorrect,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          GameTopBar(
            teamName: team.name,
            seconds: remainingSeconds,
            onEnd: onEnd,
          ),
          const SizedBox(height: 8),
          GameActorBadge(actor: team.currentActor ?? 'أحد اللاعبين'),
          const Spacer(flex: 1),
          GameWordCard(category: deck.currentCategory, word: deck.currentText),
          const Spacer(flex: 2),
          GameActionButtons(onCorrect: onCorrect, onSkip: onSkip),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}