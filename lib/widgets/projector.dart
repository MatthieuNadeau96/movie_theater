import 'package:flutter/material.dart';

class Projector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ScreenPainter(),
    );
  }
}

class ScreenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path screenPath = Path();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;

    screenPath.moveTo(0, height * 1);

    screenPath.cubicTo(width * 0.25, height * 0.25, width * 0.75, height * 0.25,
        width, height);

    paint.color = Colors.white;
    canvas.drawPath(screenPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
