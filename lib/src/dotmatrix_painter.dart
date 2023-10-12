import 'package:flutter/material.dart';

import 'package:dot_matrix_display/src/dot.dart';
import 'package:dot_matrix_display/src/dotmatrix.dart';

class DotMatrixPainter extends CustomPainter {
  double? dotSize;
  DotType? dotType;
  DotMatrix dotMatrix;
  double frameWidth;
  double offsetX = 0;
  double offsetY = 0;
  double dotDistance = 0;
  late Paint _paint;

  DotMatrixPainter({
    this.frameWidth = 10, // Only for offset calculation
    this.dotSize = 5,
    this.dotType = DotType.circle,
    required this.dotMatrix,
  }) {
    offsetX = dotSize! / 2 + frameWidth;
    offsetY = dotSize! / 2 + frameWidth;
    _paint = Paint();
    _paint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int x = 0; x < dotMatrix.sizeX; x++) {
      for (int y = 0; y < dotMatrix.sizeY; y++) {
        _paint.color = dotMatrix.dotMatrix[x][y].dotColor;

        if (dotMatrix.dotMatrix[x][y].dotType == DotType.circle) {
          canvas.drawCircle(
              dotMatrix.dotMatrix[x][y].offset, dotSize! / 2, _paint);
        } else if (dotMatrix.dotMatrix[x][y].dotType == DotType.square) {
          canvas.drawRect(
              Rect.fromCenter(
                  center: dotMatrix.dotMatrix[x][y].offset,
                  width: dotSize!,
                  height: dotSize!),
              _paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
