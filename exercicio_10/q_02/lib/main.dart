import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  FocusNode focusNode = FocusNode();
  late FocusNode focusNodeTextField;

  @override
  void initState() {
    focusNodeTextField = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    focusNodeTextField.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
        focusNode: focusNode,
        onKey: (event) {
          if (event is RawKeyDownEvent) {
            if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
              focusNodeTextField.nextFocus();
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Text Box!"),
          ),
          body: Center(
              child: SizedBox(
            width: 500,
            child: Column(
              children: [
                const TextField(
                  textInputAction: TextInputAction.none,
                  autofocus: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                const TextField(
                  textInputAction: TextInputAction.none,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                    textInputAction: TextInputAction.none,
                    focusNode: focusNodeTextField),
              ],
            ),
          )),
        ));
  }
}
