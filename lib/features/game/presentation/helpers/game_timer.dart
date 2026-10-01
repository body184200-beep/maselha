import 'dart:async';
import 'package:flutter/material.dart';

/// Countdown based on a deadline instead of counting ticks, so it stays
/// accurate when the app is backgrounded or a frame is delayed.
class GameTimer {
  GameTimer(this._remaining);

  int _remaining;
  DateTime? _deadline;
  Timer? _timer;
  VoidCallback? _onTick;
  VoidCallback? _onFinish;

  int get remaining => _remaining;

  void start({required VoidCallback onTick, required VoidCallback onFinish}) {
    _onTick = onTick;
    _onFinish = onFinish;
    resume();
  }

  void resume() {
    _timer?.cancel();
    if (_remaining <= 0) return;
    _deadline = DateTime.now().add(Duration(seconds: _remaining));
    _timer = Timer.periodic(const Duration(milliseconds: 250), (_) => _tick());
  }

  void pause() => _timer?.cancel();

  void cancel() => _timer?.cancel();

  void _tick() {
    final ms = _deadline!.difference(DateTime.now()).inMilliseconds;
    final left = ms <= 0 ? 0 : (ms / 1000).ceil();
    if (left == _remaining) return; // nothing visible changed
    _remaining = left;
    if (left == 0) {
      _timer?.cancel();
      _onFinish?.call();
    } else {
      _onTick?.call();
    }
  }
}