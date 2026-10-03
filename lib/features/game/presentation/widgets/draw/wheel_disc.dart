import 'package:flutter/material.dart';

import 'wheel_painter.dart';

/// The wheel itself plus the pointer at the top. It turns by
/// `turn * progress` radians, so the parent only drives [progress].
class WheelDisc extends StatelessWidget {
  final Animation<double> progress;
  final double turn;
  final List<String> names;
  final Color color;

  const WheelDisc({
    super.key,
    required this.progress,
    required this.turn,
    required this.names,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 260,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: progress,
            builder: (_, child) =>
                Transform.rotate(angle: turn * progress.value, child: child),
            child: CustomPaint(
              size: const Size(260, 260),
              painter: WheelPainter(names: names, color: color),
            ),
          ),
          const Positioned(
            top: -18,
            child: Icon(
              Icons.arrow_drop_down_rounded,
              size: 48,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}