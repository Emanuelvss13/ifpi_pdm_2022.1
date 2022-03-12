import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ignore: unnecessary_const
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildContainer(100, Colors.red),
                Container(
                  width: 200,
                  height: 100,
                  color: Colors.teal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      buildContainer(100, Colors.yellow, 100),
                      buildContainer(100, Colors.green, 100)
                    ],
                  ),
                ),
                buildContainer(100, Colors.blue)
              ]),
        ),
      ),
    );
  }
}

Container buildContainer(double width, Color color, [double height = 100]) {
  return Container(
    width: width,
    height: height,
    color: color,
  );
}
