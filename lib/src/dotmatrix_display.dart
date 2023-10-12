import 'package:flutter/material.dart';
import 'package:dot_matrix_display/src/dot.dart';
import 'package:dot_matrix_display/src/dotmatrix.dart';
import 'package:dot_matrix_display/src/frame_painter.dart';
import 'package:dot_matrix_display/src/dotmatrix_painter.dart';

class DotMatrixDisplay extends StatefulWidget {
  const DotMatrixDisplay({
    super.key,
    this.foreground = defaultForeground,
    this.frameColor = Colors.purple,
    this.frameBackgroundColor = Colors.transparent,
    this.frameWidth = 10,
    this.dotSize = 5,
    this.scaleFactor = 1.0,
    required this.dotMatrix,
  });
  final Color foreground;
  final Color frameColor;
  final Color frameBackgroundColor;
  final double frameWidth;
  final double dotSize;
  final double scaleFactor;
  final DotMatrix dotMatrix;

  @override
  State<DotMatrixDisplay> createState() => _DotMatrixDisplayState();
}

class _DotMatrixDisplayState extends State<DotMatrixDisplay> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: widget.scaleFactor,
      child: Stack(alignment: Alignment.center, children: <Widget>[
        Container(
            color: widget.frameBackgroundColor,
            child: CustomPaint(
                painter: FramePainter(
                    context: context,
                    color: widget.frameColor,
                    strokeWidth: widget.frameWidth),
                child: Container())),
        CustomPaint(
          painter: DotMatrixPainter(
            frameWidth: widget.frameWidth,
            dotType: DotType.circle,
            dotSize: widget.dotSize,
            dotMatrix: widget.dotMatrix,
          ),
          child: Container(),
        ),
      ]),
    );
  }
}
