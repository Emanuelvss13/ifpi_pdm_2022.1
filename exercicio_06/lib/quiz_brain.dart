import 'package:exercicio_06/sqlite.dart';
import 'package:sqflite/sqflite.dart';

import 'question.dart';

DB databaseHelper = DB.instance;

class QuizBrain {
  int _questionNumber = 0;

  final db = databaseHelper.database;

  final List<Question> _questionBank = [];

  Future<void> initializeDB() async {
    final db = await databaseHelper.database;
    await db.delete('questions');

    if (_questionBank.isNotEmpty) {
      print(_questionBank.length);
      return;
    }

    final List<Question> questionBank = [
      const Question(
          questionText:
              'Orcas não são baleias, mas sim uma espécie de golfinho.',
          questionAnswer: 1,
          id: 1),
      Question(
          questionText:
              'Segurar um espirro pode até mesmo causar o rompimento de um vaso sanguíneo.',
          questionAnswer: 2,
          id: 1),
      Question(
          questionText:
              'A cleópatra é mais próxima à criação do McDonalds do que a construção das pirâmides do Egito.',
          questionAnswer: 1,
          id: 1),
      Question(
          questionText:
              'Existem mais átomos no corpo humano do que estrelas no Universo.',
          questionAnswer: 1,
          id: 1),
      Question(
          questionText: 'A asa de um mosquito se move 1000 vezes por segundo.',
          questionAnswer: 1,
          id: 1),
      Question(
          questionText:
              'Há mais bactérias em sua boca do que pessoas no planeta Terra.',
          questionAnswer: 1,
          id: 1),
      Question(
          questionText:
              'A chance de se ter uma pessoa com uma impressão digital igual a outra é a mesma de ganhar na loteria 50 vezes.',
          questionAnswer: 2,
          id: 1),
      Question(
          questionText:
              'Um estudo comprovou que a comida preferida dos ratos é queijo.',
          questionAnswer: 2,
          id: 1),
      Question(
          questionText:
              'O Pernalonga não é um coelho, mas sim uma espécie de lebre.',
          questionAnswer: 1,
          id: 1),
      Question(
          questionText: 'Os golfinhos costumam dar nomes uns aos outros.',
          questionAnswer: 1,
          id: 1),
      Question(
          questionText: 'Foi Napoleão quem destruiu o nariz da esfinge.',
          questionAnswer: 2,
          id: 1),
      Question(
          questionText:
              'A grande muralha da China foi construída com o proposito de proteger o império recém unificado.',
          questionAnswer: 2,
          id: 1),
      Question(
          questionText:
              'A miopia é causada por alta exposição à luminosidade das telas dos aparelhos eletrônicos.',
          questionAnswer: 2,
          id: 1),
    ];

    for (var question in questionBank) {
      await db.insert(
        'questions',
        question.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    final List<Map<String, dynamic>> maps = await db.query('questions');

    List.generate(maps.length, (i) {
      _questionBank.add(Question(
        id: i,
        questionText: maps[i]['questionText'],
        questionAnswer: maps[i]['questionAnswer'],
      ));
    });

    print(_questionBank.length);
  }

  void nextQuestion() {
    if (_questionNumber < _questionBank.length) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  int getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    if (_questionNumber > _questionBank.length) {
      return true;
    } else {
      print(_questionBank.length);
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
