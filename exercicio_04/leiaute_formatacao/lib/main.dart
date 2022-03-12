import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildContainer('1', Colors.yellowAccent),
                buildContainer('2', Colors.red),
                buildContainer('3', Colors.blue),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildContainer(String text, Color color) {
    return Container(
      width: 100,
      height: 100,
      color: color,
      child: Center(
          child: Text(
        text,
        style: const TextStyle(fontSize: 30),
      )),
    );
  }
}
