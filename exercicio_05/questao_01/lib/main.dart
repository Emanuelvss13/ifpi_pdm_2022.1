import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text("Dicee"),
        backgroundColor: Colors.red,
      ),
      body: const Dicee(),
    ),
  ));
}

class Dicee extends StatefulWidget {
  const Dicee({Key? key}) : super(key: key);

  @override
  State<Dicee> createState() => _DiceeState();
}

class _DiceeState extends State<Dicee> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;

  void changeDiceState() {
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1;
      rightDiceNumber = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
              child: TextButton(
                  onPressed: () {
                    changeDiceState();
                  },
                  child: Image.asset("images/dice$leftDiceNumber.png"))),
          Expanded(
              child: TextButton(
                  onPressed: () {
                    changeDiceState();
                  },
                  child: Image.asset("images/dice$rightDiceNumber.png")))
        ],
      ),
    );
  }
}
