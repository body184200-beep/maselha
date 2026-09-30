import 'dart:async';
import 'package:flutter/material.dart';

class GameTimer {
  GameTimer(this.remaining);

  int remaining;
  Timer? _timer;

  void start({required VoidCallback onTick, required VoidCallback onFinish}) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remaining > 1) {
        remaining--;
        onTick();
      } else {
        t.cancel();
        remaining = 0;
        onFinish();
      }
    });
  }

  void cancel() => _timer?.cancel();
}