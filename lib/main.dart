import 'package:flutter/material.dart';

import 'package:dot_matrix_display/src/dotmatrix_dot_patterns.dart';
// import 'package:dot_matrix_display/src/dotmatrix_number_set.dart';
import 'package:dot_matrix_display/src/dotmatrix.dart';
import 'package:dot_matrix_display/src/dotmatrix_display.dart';

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
  TextEditingController patternCode = TextEditingController(text: 'Á');
  int x = 0;
  int y = 0;
  double dotSize = 20;
  double frameWidth = 10;
  late DotMatrix dotMatrix;
  int sizeX = 700;
  int sizeY = 500;

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

  void getPatternCode(String code) {
    Map patternMap = charMap;

    dotMatrix.clear();
    dotMatrix.insertDotArray(0, 0, patternMap[code]);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      TextFormField(
        controller: patternCode,
        maxLength: 2,
        onFieldSubmitted: getPatternCode,
      ),
      Container(
          width: 400,
          height: 500,
          child: DotMatrixDisplay(
            frameColor: Colors.purple,
            frameBackgroundColor: Colors.cyan,
            dotSize: dotSize,
            scaleFactor: 1.0,
            dotMatrix: dotMatrix,
          )),
    ])));
  }
}
