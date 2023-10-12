import 'package:flutter/material.dart';
import 'package:dot_matrix_display/src/dot.dart';

class DotMatrix {
  int sizeX;
  int sizeY;
  double dotSize;
  double dotDistance;
  Color dotColor;
  double? frameWidth;
  Offset matrixOffset;
  List<List<Dot>> dotMatrix = [];

  DotMatrix(
      {required this.sizeX,
      required this.sizeY,
      this.dotSize = 5,
      this.dotDistance = 0,
      required this.dotColor,
      this.frameWidth = 0,
      this.matrixOffset = Offset.zero}) {
    frameWidth ?? dotSize;
    dotMatrix = List.generate(sizeX,
        (index) => List.generate(sizeY, (index) => Dot(), growable: false),
        growable: false);

    for (int x = 0; x < sizeX; x++) {
      for (int y = 0; y < sizeY; y++) {
        dotMatrix[x][y].offset = Offset(
            frameWidth! +
                dotSize / 2 +
                matrixOffset.dx +
                x * (dotSize + dotDistance),
            frameWidth! +
                dotSize / 2 +
                matrixOffset.dy +
                y * (dotSize + dotDistance));
        dotMatrix[x][y].on = false;
        dotMatrix[x][y].dotColor =
            dotMatrix[x][y].on ? dotColor : Colors.transparent;
      }
    }
  }

  /*
   * Clears the entire matrix, ie all dots are drawn in background color
   */
  void clear() {
    for (int x = 0; x < sizeX; x++) {
      for (int y = 0; y < sizeY; y++) {
        dotMatrix[x][y].on = false;
        dotMatrix[x][y].dotColor = Colors.transparent;
      }
    }
  }

  /*
   * Draws a single dot at given position x, y (0:0 is at the very top left of the dot matrix) defined by a string containing '0's and '1's (=columns).
   * the rows are represented by list of those strings to switch dots on (='1') and
   * off (='0'). The dot shape and dot color may be individualized.
   */
  void singleDot(x, y, {DotType dotType = DotType.circle}) {
    dotMatrix[x][y].dotType = dotType;
    dotMatrix[x][y].on = !dotMatrix[x][y].on;
    dotMatrix[x][y].dotColor =
        dotMatrix[x][y].on ? dotColor : Colors.transparent;
  }

  /*
   * Inserts a pattern at given position x and y (0:0 is at the very top left of the dot matrix) defined by a string containing '0's and '1's (=columns).
   * the rows are represented by list of those strings to switch dots on (='1') and
   * off (='0')
   */
  void insertDotArray(posX, posY, List<String> array) {
    for (int x = 0; x < array[0].length; x++) {
      for (int y = 0; y < array.length; y++) {
        if (array[y][x] == '1') {
          singleDot(posX + x, posY + y);
        }
      }
    }
  }

  @override
  String toString() {
    String text = '';

    for (int y = 0; y < sizeY - 1; y++) {
      for (int x = 0; x < sizeX - 1; x++) {
        text += dotMatrix[x][y].on ? 'X' : '_';
      }
      text += '\n';
    }
    return text;
  }
}
