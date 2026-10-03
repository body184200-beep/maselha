import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Draws the wheel: one slice per name. Slice 0 starts at the top and the
/// slices go clockwise, which is what [NameWheel] relies on to land on a name.
class WheelPainter extends CustomPainter {
  final List<String> names;
  final Color color;

  const WheelPainter({required this.names, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;
    final sweep = 2 * pi / names.length;
    final dark = Color.alphaBlend(Colors.black.withValues(alpha: 0.35), color);
    final paint = Paint();

    for (var i = 0; i < names.length; i++) {
      final start = -pi / 2 + i * sweep;
      paint.color = i.isEven ? color : dark;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        start,
        sweep,
        true,
        paint,
      );
      _drawName(canvas, center, radius, start + sweep / 2, names[i]);
    }
  }

  void _drawName(
      Canvas canvas,
      Offset center,
      double radius,
      double angle,
      String name,
      ) {
    final text = TextPainter(
      text: TextSpan(
        text: name,
        style: GoogleFonts.cairo(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.rtl,
      maxLines: 1,
      ellipsis: '…',
    )..layout(maxWidth: radius * 0.65);

    canvas
      ..save()
      ..translate(center.dx, center.dy)
      ..rotate(angle);
    text.paint(canvas, Offset(radius * 0.25, -text.height / 2));
    canvas.restore();
  }

  @override
  bool shouldRepaint(WheelPainter old) =>
      old.names != names || old.color != color;
}