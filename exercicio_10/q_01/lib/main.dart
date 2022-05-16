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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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
  List<bool> format = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Formatar texto!"),
        ),
        body: Center(
          child: Column(children: [
            const SizedBox(height: 100),
            Text("Hello World!",
                style: TextStyle(
                    fontSize: 50,
                    decoration: format[2]
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    fontWeight: format[1] ? FontWeight.bold : FontWeight.normal,
                    fontStyle:
                        format[0] ? FontStyle.italic : FontStyle.normal)),
            const SizedBox(height: 100),
            ToggleButtons(
                children: const <Widget>[
                  Icon(Icons.format_italic),
                  Icon(Icons.format_bold),
                  Icon(Icons.format_underlined),
                ],
                onPressed: (int index) {
                  setState(() {
                    format[index] = !format[index];
                  });
                },
                isSelected: format),
          ]),
        ));
  }
}
