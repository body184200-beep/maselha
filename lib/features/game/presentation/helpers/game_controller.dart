import 'package:flutter/material.dart';

import '../../../game_setup/data/models/team_model.dart';
import 'game_screen_state.dart';
import 'game_timer.dart';
import 'word_deck.dart';

class GameController extends ChangeNotifier {
  final TeamModel team;
  final WordDeck deck;
  final GameTimer timer;

  /// Points for a correct word (50 in a penalty, 10 otherwise).
  final int pointsPerWord;

  /// Penalty mode: the turn is one word, no skipping.
  final bool singleWord;

  GameScreenState state = GameScreenState.playing;

  GameController({
    required this.team,
    required this.deck,
    required int seconds,
    this.pointsPerWord = 10,
    this.singleWord = false,
  }) : timer = GameTimer(seconds) {
    timer.start(
      onTick: notifyListeners,
      onFinish: () => _setState(GameScreenState.timeUp),
    );
  }

  void _setState(GameScreenState s) {
    state = s;
    notifyListeners();
  }

  void onCorrect() {
    if (state != GameScreenState.playing || deck.isEmpty) return;
    team.score += pointsPerWord;
    timer.pause(); // the clock doesn't run while waiting on the result screen
    _setState(GameScreenState.correct);
  }

  void nextAfterCorrect() {
    if (state != GameScreenState.correct) return;
    deck.next();
    timer.resume();
    _setState(GameScreenState.playing);
  }

  void skip() {
    if (singleWord) return;
    if (state != GameScreenState.playing || deck.isEmpty) return;
    deck.next();
    notifyListeners();
  }

  /// Used while a dialog is open on top of the game.
  void pause() => timer.pause();

  void resume() {
    if (state == GameScreenState.playing) timer.resume();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}