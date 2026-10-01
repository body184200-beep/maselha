import 'package:flutter/material.dart';

import '../../../../core/theme/appColors.dart';

/// Page frame for the game: RTL, background, safe area, and a back button
/// that asks to end the game ([onBack]) instead of abandoning it.
class GameShell extends StatelessWidget {
  final VoidCallback onBack;
  final Widget child;

  const GameShell({super.key, required this.onBack, required this.child});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) onBack();
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(child: child),
        ),
      ),
    );
  }
}