import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class Projector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ScreenPainter(
        color1: Theme.of(context).canvasColor,
        color2: Theme.of(context).primaryColor,
      ),
    );
  }
}

class ScreenPainter extends CustomPainter {
  final Color color1;
  final Color color2;
  ScreenPainter({
    this.color1,
    this.color2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;

    // Movie Screen
    Paint screenPaint = Paint();
    Path screenPath = Path();
    screenPaint.style = PaintingStyle.stroke;
    screenPaint.strokeWidth = 3;
    screenPath.moveTo(0, height * 1);

    screenPath.cubicTo(width * 0.25, height * 0.25, width * 0.75, height * 0.25,
        width, height);

    screenPaint.color = Colors.white;
    canvas.drawPath(screenPath, screenPaint);

    // Movie Projection
    Path projection = Path();
    Paint projectionPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(50, 0),
        Offset(50, 60),
        [
          color1,
          color2.withOpacity(0),
        ],
      );

    projection.moveTo(0, height * 1);
    projection.cubicTo(width * 0.25, height * 0.26, width * 0.75, height * 0.26,
        width, height);
    // projection.lineTo(0, height)
    projection.cubicTo(
        width * 0.25, height / 0.75, width * 0.75, height / 0.75, 0, height);
    projection.close();

    projectionPaint.color = Colors.red;
    canvas.drawPath(projection, projectionPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
