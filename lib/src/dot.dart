import 'package:flutter/material.dart';

enum DotType { circle, square }

const Color defaultForeground = Colors.red;
const Color defaultBackground = Colors.black12;

class Dot {
  Offset offset = Offset.zero;
  DotType dotType = DotType.circle;
  Color dotColor = defaultForeground;
  bool on = false;
}
