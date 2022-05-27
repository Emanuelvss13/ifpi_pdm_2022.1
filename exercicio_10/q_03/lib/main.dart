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
  List<bool> terms = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Política de privacidade"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const SizedBox(
              width: 300,
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed semper ligula nec neque tincidunt facilisis. Integer lacus lacus, feugiat sit amet egestas ut, finibus at sapien. Curabitur tempus orci vel ex dictum, a lobortis ante scelerisque. Maecenas condimentum eget justo vitae ullamcorper. Sed quis suscipit dolor, sed dictum odio. Donec.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            CheckboxListTile(
                title: const Text("Aceito o acesso a minha localização"),
                value: terms[0],
                onChanged: (value) {
                  setState(() {
                    terms[0] = value!;
                  });
                }),
            CheckboxListTile(
                title: const Text("Aceito a politica de privacidade"),
                value: terms[1],
                onChanged: (bool? value) {
                  setState(() {
                    terms[1] = value!;
                  });
                }),
            CheckboxListTile(
                title: const Text(
                    "Aceito que vendam meus dados para o governo chinês"),
                value: terms[2],
                onChanged: (bool? value) {
                  setState(() {
                    terms[2] = value!;
                  });
                }),
            CheckboxListTile(
              title: const Text("Aceitar todos"),
              value: terms[0] && terms[1] && terms[2]
                  ? true
                  : terms.contains(true)
                      ? null
                      : false,
              tristate: true,
              onChanged: (bool? value) {
                setState(() {
                  terms[0] = value!;
                  terms[1] = value;
                  terms[2] = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
