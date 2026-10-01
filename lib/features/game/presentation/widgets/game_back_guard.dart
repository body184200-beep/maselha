import 'package:flutter/material.dart';

/// Blocks the system back button and routes it to [onBack]
/// (here: the "end game?" confirmation) instead of abandoning the game.
class GameBackGuard extends StatelessWidget {
  final VoidCallback onBack;
  final Widget child;

  const GameBackGuard({super.key, required this.onBack, required this.child});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) onBack();
      },
      child: child,
    );
  }
}