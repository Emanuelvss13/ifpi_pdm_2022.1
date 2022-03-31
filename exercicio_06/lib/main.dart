import 'package:flutter/material.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await quizBrain.initializeDB();
  runApp(const Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(15, 15, 15, 1),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int score = 0;
  int percent = 0;

  void checkAnswer(int userPickedAnswer) {
    int correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (quizBrain.isFinished()) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Acertou $percent%'),
          action: SnackBarAction(
            label: 'Reiniciar',
            onPressed: () {
              setState(() {
                quizBrain.reset();
                scoreKeeper = [];
                score = 0;
                percent = 0;
              });
            },
          ),
        ));
      } else {
        if (userPickedAnswer == 3) {
          scoreKeeper.add(const Icon(
            Icons.warning,
            color: Color.fromRGBO(255, 218, 185, 1),
          ));
        } else if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(const Icon(
            Icons.check,
            color: Color.fromRGBO(76, 175, 80, 1),
          ));
          score++;
        } else if (userPickedAnswer != correctAnswer) {
          scoreKeeper.add(const Icon(
            Icons.close,
            color: Color.fromRGBO(244, 67, 54, 1),
          ));
        }
        quizBrain.nextQuestion();
      }

      percent = (scoreKeeper.isEmpty ? 0 : (score / scoreKeeper.length) * 100)
          .round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          "$percent%",
          style: const TextStyle(color: Colors.white),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(1);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(2);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              color: const Color.fromRGBO(45, 46, 46, 1),
              child: const Text(
                'Maybe',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(3);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
