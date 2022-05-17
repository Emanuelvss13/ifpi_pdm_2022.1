import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
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
  double zoomValue = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zoom"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Transform.scale(
              scale: zoomValue == 0 ? 0.2 : zoomValue / 25,
              child: Image.network(
                "https://ae01.alicdn.com/kf/HTB185UUOVXXXXaNXFXXq6xXFXXXt/Imagens-de-paisagem-naturais-3-d-papel-de-parede-para-mural-sof-decorar-uma-sala-plano.jpg_Q90.jpg_.webp",
                width: 500,
              ),
            ),
            Spacer(),
            Slider(
              value: zoomValue,
              max: 100,
              divisions: 10,
              label: zoomValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  zoomValue = value;
                });
              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
