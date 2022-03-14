import 'package:flutter/material.dart';
import 'package:questao_04/icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(62, 9, 77, 1),
        body: SafeArea(
            child: Stack(children: [
          const Positioned(
            top: 0,
            left: -50,
            child: Image(
              image: AssetImage('images/design.png'),
              height: 140,
              repeat: ImageRepeat.repeatX,
              color: Color.fromRGBO(89, 36, 107, 1),
            ),
          ),
          Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 120,
                backgroundImage: AssetImage('images/emanuel.jpg'),
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 50,
                runSpacing: 30,
                alignment: WrapAlignment.center,
                children: [
                  buildIcon(
                    Icons.facebook,
                    70,
                  ),
                  buildIcon(
                    MediaIcon.instagram,
                    70,
                  ),
                  buildIcon(
                    MediaIcon.github,
                    70,
                  ),
                  buildIcon(
                    Icons.message,
                    70,
                  ),
                  buildIcon(
                    Icons.whatsapp,
                    70,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SizedBox(
                width: 200,
                height: 60,
                child: Image(image: AssetImage('images/skibrand.jpg')),
              ),
              const SizedBox(height: 10),
              const Text("Emanuel \n Vítor",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
              const SizedBox(height: 5),
              const Text(
                "Flutter Developer",
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            ]),
          ),
          const Positioned(
            top: 180,
            right: -80,
            child: Image(
              image: AssetImage('images/design.png'),
              height: 125,
              repeat: ImageRepeat.repeatX,
              color: Color.fromRGBO(89, 36, 107, 1),
            ),
          ),
        ])),
      ),
    );
  }
}

Icon buildIcon(IconData icon, double size) {
  return Icon(
    icon,
    size: size,
    color: const Color.fromRGBO(250, 18, 92, 1),
  );
}
