import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: const Text('I am poor'),
      backgroundColor: Colors.grey,
    ),
    body: const Center(
      child: Image(image: AssetImage('images/poor.png')),
    ),
  )));
}
