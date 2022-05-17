import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool light = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            const Spacer(),
            switchLight(light),
            const Spacer(),
            Switch(
                value: light,
                onChanged: (bool value) {
                  setState(() {
                    light = value;
                  });
                }),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

Image switchLight(bool mode) {
  if (mode) {
    return Image.asset("on.png");
  }

  return Image.asset("off.png");
}
