import 'package:flutter/material.dart';

import 'package:dot_matrix_display/src/dotmatrix_dot_patterns.dart';
import 'package:dot_matrix_display/src/dotmatrix.dart';
import 'package:dot_matrix_display/src/dotmatrix_display_steady.dart';

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
  int lineCount = 0;
  TextEditingController text = TextEditingController(text: 'A');
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
        sizeX: (sizeX / dotSize).floor() - (frameWidth / dotSize).floor(),
        sizeY: (sizeY / dotSize).floor() - (frameWidth / dotSize).floor(),
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

    dotMatrix.clear();

    for (int i = 0; i <= text.length - 1; i++) {
      dotMatrix.insertDotArray(colIndex, rowIndex, patternMap[text[i]]);
      patternWidth = patternMap[text[i]][0].length;
      patternHeight = patternMap[text[i]].length;
      colIndex += patternWidth;

      if ((patternWidth * text.length) >= MediaQuery.of(context).size.width) {
        colIndex = 0;
        rowIndex += patternHeight + 1;
      }
    }

    lineCount = 0;

    for (int charCount = 0; charCount < text.length; charCount++) {
      dotMatrix.insertDotArray(charCount * (patternWidth + 1), lineCount,
          patternMap[text[charCount]]);
      // if (charCount * (patternWidth + 1) > dotMatrix.sizeX) {
      //   lineCount++;
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
      TextFormField(
        controller: text,
        onFieldSubmitted: getPatternCode,
      ),
      Expanded(
          child: SizedBox(
              width: sizeX.floorToDouble(),
              height: sizeY.floorToDouble(),
              child: DotMatrixDisplay(
                frameColor: Colors.white, //Colors.purple,
                frameBackgroundColor: Colors.amberAccent, // Colors.cyan,
                frameWidth: 5,
                dotSize: dotSize,
                scaleFactor: 0.5,
                dotMatrix: dotMatrix,
              )))
    ])));
  }
}
