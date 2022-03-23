import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Gallery"),
        backgroundColor: Colors.red,
      ),
      body: const Control(),
    ),
  ));
}

class Control extends StatefulWidget {
  const Control({Key? key}) : super(key: key);

  @override
  State<Control> createState() => _ControlState();
}

class _ControlState extends State<Control> {
  int _imagePage = 1;

  void _incrementImagePage() {
    setState(() {
      if (_imagePage <= 5) _imagePage++;
    });
  }

  void _decrementImagePage() {
    setState(() {
      if (_imagePage > 1) _imagePage--;
    });
  }

  StatefulWidget _showImage() {
    switch (_imagePage) {
      case 1:
        return const One();
      case 2:
        return const Two();
      case 3:
        return const Three();
      case 4:
        return const Four();
      default:
        return const Five();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(_imagePage.toString()),
          _showImage(),
          TextButton(
              onPressed: () {
                _incrementImagePage();
              },
              child: const Icon(
                Icons.navigate_next,
                size: 100,
              )),
          TextButton(
              onPressed: () {
                _decrementImagePage();
              },
              child: const Icon(Icons.navigate_before, size: 100)),
        ],
      ),
    );
  }
}

class One extends StatefulWidget {
  const One({Key? key}) : super(key: key);

  @override
  State<One> createState() {
    return _OneState();
  }
}

class _OneState extends State<One> {
  bool _like = prefs.getBool("1")!;

  void _changeLike(String number) async {
    setState(() {
      _like = !_like;
    });

    await prefs.setBool("1", _like);
  }

  @override
  Widget build(BuildContext context) {
    return heart(_changeLike, _like, "1");
  }
}

class Two extends StatefulWidget {
  const Two({Key? key}) : super(key: key);

  @override
  State<Two> createState() => _TwoState();
}

class _TwoState extends State<Two> {
  bool _like = prefs.getBool("2")!;

  void _changeLike(String number) async {
    setState(() {
      _like = !_like;
    });

    await prefs.setBool("2", _like);
  }

  @override
  Widget build(BuildContext context) {
    return heart(_changeLike, _like, "2");
  }
}

class Three extends StatefulWidget {
  const Three({Key? key}) : super(key: key);

  @override
  State<Three> createState() => _ThreeState();
}

class _ThreeState extends State<Three> {
  bool _like = prefs.getBool("3")!;

  void _changeLike(String number) async {
    setState(() {
      _like = !_like;
    });

    await prefs.setBool("3", _like);
  }

  @override
  Widget build(BuildContext context) {
    return heart(_changeLike, _like, "3");
  }
}

class Four extends StatefulWidget {
  const Four({Key? key}) : super(key: key);

  @override
  State<Four> createState() => _FourState();
}

class _FourState extends State<Four> {
  bool _like = prefs.getBool("4")!;

  void _changeLike(String number) async {
    setState(() {
      _like = !_like;
    });

    await prefs.setBool("4", _like);
  }

  @override
  Widget build(BuildContext context) {
    return heart(_changeLike, _like, "4");
  }
}

class Five extends StatefulWidget {
  const Five({Key? key}) : super(key: key);

  @override
  State<Five> createState() => _FiveState();
}

class _FiveState extends State<Five> {
  bool _like = prefs.getBool("5")!;

  void _changeLike(String number) async {
    setState(() {
      _like = !_like;
    });

    await prefs.setBool("5", _like);
  }

  @override
  Widget build(BuildContext context) {
    return heart(_changeLike, _like, "5");
  }
}

Center heart(Function changeLike, bool like, String number) {
  return Center(
    child: Column(
      children: [
        TextButton(
            onPressed: () {
              changeLike(number);
            },
            child: image(like)),
        Text(
          number,
          style: const TextStyle(fontSize: 40),
        )
      ],
    ),
  );
}

Image image(bool bool) {
  if (bool) return Image.asset("images/like.png");

  return Image.asset("images/noLike.png");
}
