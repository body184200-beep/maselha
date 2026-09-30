import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/appColors.dart';
import 'game_end_button.dart';

/// Team pill, end button, and timer pill.
class GameTopBar extends StatelessWidget {
  final String teamName;
  final int seconds;
  final VoidCallback onEnd;

  const GameTopBar({
    super.key,
    required this.teamName,
    required this.seconds,
    required this.onEnd,
  });

  String get _time {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _Pill(children: [
          _label(teamName, 14),
          const SizedBox(width: 6),
          const Icon(Icons.arrow_forward_rounded,
              color: AppColors.white, size: 16),
        ]),
        GameEndButton(onTap: onEnd),
        _Pill(children: [
          const Icon(Icons.timer_outlined, color: AppColors.white, size: 18),
          const SizedBox(width: 6),
          _label(_time, 15),
        ]),
      ],
    );
  }

  Widget _label(String text, double size) => Text(
    text,
    style: GoogleFonts.cairo(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: AppColors.white,
    ),
  );
}

class _Pill extends StatelessWidget {
  final List<Widget> children;

  const _Pill({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: children),
    );
  }
}