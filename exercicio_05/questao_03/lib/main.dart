import 'package:flutter/material.dart';

void main() {
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

//DB
List<bool> likes = [false, false, false, false, false];

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
  bool _like = likes[0];

  void changeLike() {
    setState(() {
      _like = !likes[0];
      likes[0] = _like;
    });
  }

  @override
  Widget build(BuildContext context) {
    return heart(changeLike, _like, 1);
  }
}

class Two extends StatefulWidget {
  const Two({Key? key}) : super(key: key);

  @override
  State<Two> createState() => _TwoState();
}

class _TwoState extends State<Two> {
  bool _like = likes[1];

  void changeLike() {
    setState(() {
      _like = !likes[1];
      likes[1] = _like;
    });
  }

  @override
  Widget build(BuildContext context) {
    return heart(changeLike, _like, 2);
  }
}

class Three extends StatefulWidget {
  const Three({Key? key}) : super(key: key);

  @override
  State<Three> createState() => _ThreeState();
}

class _ThreeState extends State<Three> {
  bool _like = likes[2];

  void changeLike() {
    setState(() {
      _like = !likes[2];
      likes[2] = _like;
    });
  }

  @override
  Widget build(BuildContext context) {
    return heart(changeLike, _like, 3);
  }
}

class Four extends StatefulWidget {
  const Four({Key? key}) : super(key: key);

  @override
  State<Four> createState() => _FourState();
}

class _FourState extends State<Four> {
  bool _like = likes[3];

  void changeLike() {
    setState(() {
      _like = !likes[3];
      likes[3] = _like;
    });
  }

  @override
  Widget build(BuildContext context) {
    return heart(changeLike, _like, 4);
  }
}

class Five extends StatefulWidget {
  const Five({Key? key}) : super(key: key);

  @override
  State<Five> createState() => _FiveState();
}

class _FiveState extends State<Five> {
  bool _like = likes[4];

  void changeLike() {
    setState(() {
      _like = !likes[4];
      likes[4] = _like;
    });
  }

  @override
  Widget build(BuildContext context) {
    return heart(changeLike, _like, 5);
  }
}

Center heart(Function changeLike, bool like, int number) {
  return Center(
    child: Column(
      children: [
        TextButton(
            onPressed: () {
              changeLike();
            },
            child: image(like)),
        Text(
          number.toString(),
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
