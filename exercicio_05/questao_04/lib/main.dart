import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        buttonTheme: const ButtonThemeData(
      buttonColor: Colors.deepPurple,
    )),
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Advinhe o número!"),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: const Component(),
    ),
  ));
}

class Component extends StatefulWidget {
  const Component({Key? key}) : super(key: key);

  @override
  State<Component> createState() => _ComponentState();
}

class _ComponentState extends State<Component> {
  int correctAnswer = Random().nextInt(10 - 1) + 1;
  int userAnswer = 11;
  String tip = "";

  void changeUserAnswer(int number) {
    setState(() {
      userAnswer = number;
    });
  }

  void delayAnswer() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        tip = "";
      });
    });
  }

  void checkAnswer() {
    if (correctAnswer == userAnswer) {
      setState(() {
        tip = "Resposta correta!";
        correctAnswer = Random().nextInt(10 - 1) + 1;
        userAnswer = 11;
      });
      delayAnswer();
    } else if (userAnswer == 11) {
      setState(() {
        tip = "Escolha um número!";
      });
      delayAnswer();
    } else if (userAnswer > correctAnswer) {
      setState(() {
        tip = "Escolha um número menor";
      });
      delayAnswer();
    } else if (userAnswer < correctAnswer) {
      setState(() {
        tip = "Escolha um número maior";
      });
      delayAnswer();
    }
  }

  final items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Text("$correctAnswer"),
        Center(
          child: SizedBox(
            width: 350,
            child: DropdownButtonFormField<int>(
                autofocus: true,
                decoration: InputDecoration(
                    label: const Text("Tente sua sorte!",
                        style: TextStyle(fontSize: 20)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6))),
                isExpanded: true,
                hint: const Text("Escolha um número!",
                    style: TextStyle(fontSize: 25)),
                value: userAnswer == 11 ? null : userAnswer,
                onChanged: (option) => changeUserAnswer(option!),
                items: items
                    .map((i) => DropdownMenuItem(
                          child: Text(i.toString(),
                              style: const TextStyle(fontSize: 20)),
                          value: i,
                        ))
                    .toList()),
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        SizedBox(
          width: 250,
          child: TextButton(
            onPressed: () => {checkAnswer()},
            style: TextButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              padding: const EdgeInsets.all(20),
            ),
            child: const Text("Escolher",
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
        const SizedBox(
          height: 200,
        ),
        Text(
          "$tip",
          style: const TextStyle(fontSize: 30),
        )
      ],
    ));
  }
}
