import 'package:flutter/material.dart';
import 'dart:math';

class WheelSlicePainter extends CustomPainter {
  WheelSlicePainter({
    required this.divider,
    required this.number,
    required this.color
  });

  final int divider;
  final int number;
  final Color? color;

  Paint? currentPaint;
  double angleWidth = 0;

  @override
  void paint(Canvas canvas, Size size) {
    _initializeFill();
    _drawSlice(canvas, size);
  }

  void _initializeFill() {
    currentPaint = Paint()..color = color != null
        ? color!
        : Color.lerp(Colors.red, Colors.orange, number / (divider -1))!;

    angleWidth = pi * 2 / divider;
  }

  void _drawSlice(Canvas canvas, Size size) {
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        height: size.height,
        width: size.width,
      ),
      0,
      angleWidth,
      true,
      currentPaint!,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
