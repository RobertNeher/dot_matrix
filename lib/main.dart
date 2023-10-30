import 'package:flutter/material.dart';

import 'package:dot_matrix_display/src/dotmatrix_dot_patterns.dart';
import 'package:dot_matrix_display/src/dotmatrix.dart';
import 'package:dot_matrix_display/src/dotmatrix_display_scrolling.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Dot Matrix Display',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyHomePage(
          title: 'Dot Matrix Display',
          context: context,
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, this.title = '', this.context});
  final String title;
  final BuildContext? context;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController patternCode = TextEditingController(text: 'A');
  int x = 0;
  int y = 0;
  double dotSize = 5;
  double frameWidth = 10;
  late DotMatrix dotMatrix;
  int sizeX = 700;
  int sizeY = 700;

  @override
  void initState() {
    x = 0;
    y = 0;

    dotMatrix = DotMatrix(
        sizeX: (sizeX / dotSize).floor() - (frameWidth / dotSize).floor() - 3,
        sizeY: (sizeY / dotSize).floor() - (frameWidth / dotSize).floor() - 2,
        dotDistance: 1,
        frameWidth: frameWidth,
        dotSize: dotSize,
        dotColor: Colors.red);

    super.initState();
  }

  void getPatternCode(String text) {
    int rowIndex = 0;
    int colIndex = 0;
    int patternWidth = 0;
    int patternHeight = 0;
    Map _patternMap = patternMap;

    dotMatrix.clear();

    for (int i = 0; i <= text.length - 1; i++) {
      dotMatrix.insertDotArray(colIndex, rowIndex, _patternMap[text[i]]);
      patternWidth = _patternMap[text[i]][0].length - 1;
      patternHeight = _patternMap[text[i]].length;
      colIndex += patternWidth;

      if ((patternWidth * text.length) >= MediaQuery.of(context).size.width) {
        colIndex = 0;
        rowIndex += patternHeight + 1;
      }
    }

    lineCount = 0;

    for (int charCount = 0; charCount < code.length; charCount++) {
      dotMatrix.insertDotArray(charCount * (charDotWidth + 1), lineCount,
          patternMap[code[charCount]]);
      // if (l > dotMatrix.sizeX) {
      // lineCount++;
      // }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    sizeX = MediaQuery.of(context).size.width.floor();
    sizeY = MediaQuery.of(context).size.height.floor();

    return Scaffold(
        body: Form(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      // Container(
      //     color: Colors.black,
      //     child: Text(
      //       // 'ABCDEFGHIJKLMNOPQRSTUVWXYZ\n',
      //       // '!"\$%&/()=?`{}[]\\´*+\'#~;,:._-<>|\n',
      //       // '01234567890\n',
      //       'abcdefghijklmnopqrstuvwxyz',
      //       style: const TextStyle(
      //         color: Colors.yellow,
      //         fontFamily: 'DotMatrix',
      //         fontSize: 72,
      //       ),
      //     )),
      TextFormField(
        controller: patternCode,
        // maxLength: 2,
        onFieldSubmitted: getPatternCode,
      ),
      Container(
          width: sizeX.floorToDouble(),
          height: sizeY.floorToDouble(),
          child: DotMatrixDisplay(
            frameColor: Colors.purple,
            frameBackgroundColor: Colors.cyan,
            dotSize: dotSize,
            scaleFactor: 1.0,
            dotMatrix: dotMatrix,
          ))
    ])));
  }
}
