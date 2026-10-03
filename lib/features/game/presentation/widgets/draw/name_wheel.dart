import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../../core/widgets/appButton.dart';
import 'wheel_disc.dart';

/// A names wheel. The winner is drawn first, then the wheel spins so that
/// the winner's slice stops under the pointer at the top.
class NameWheel extends StatefulWidget {
  final List<String> names;
  final Color color;

  /// Called with the winner's index once the wheel stops.
  final ValueChanged<int> onResult;

  const NameWheel({
    super.key,
    required this.names,
    required this.color,
    required this.onResult,
  });

  @override
  State<NameWheel> createState() => _NameWheelState();
}

class _NameWheelState extends State<NameWheel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  );
  late final Animation<double> _curve =
  CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);

  double _turn = 0; // total rotation of the spin, in radians
  bool _spinning = false;
  bool _done = false;

  void _spin() {
    final count = widget.names.length;
    final winner = Random().nextInt(count);
    final sweep = 2 * pi / count;
    // 5 full turns, then back to the middle of the winner's slice.
    _turn = 2 * pi * 5 - (winner + 0.5) * sweep;
    setState(() => _spinning = true);

    _controller.forward().whenComplete(() {
      if (!mounted) return;
      setState(() {
        _spinning = false;
        _done = true;
      });
      widget.onResult(winner);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WheelDisc(
          progress: _curve,
          turn: _turn,
          names: widget.names,
          color: widget.color,
        ),
        const SizedBox(height: 24),
        if (!_done)
          AppButton(
            text: _spinning ? 'جاري اللف...' : 'لف العجلة',
            onPressed: () {
              if (!_spinning) _spin();
            },
          ),
      ],
    );
  }
}