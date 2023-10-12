import 'package:flutter/material.dart';

class FramePainter extends CustomPainter {
  BuildContext? context;
  late final double height;
  late final double width;
  final double strokeWidth;
  final Color color;

  FramePainter({
    this.context,
    this.strokeWidth = 5,
    this.color = Colors.transparent,
  }) {
    height = MediaQuery.of(context!).size.height;
    width = MediaQuery.of(context!).size.width;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;

    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            height: size.height,
            width: size.width),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
