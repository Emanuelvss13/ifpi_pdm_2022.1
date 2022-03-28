import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;

  final List<Question> _questionBank = [
    Question('Orcas não são baleias, mas sim uma espécie de golfinho.', 1),
    Question(
        'Segurar um espirro pode até mesmo causar o rompimento de um vaso sanguíneo.',
        2),
    Question(
        'A cleópatra é mais próxima à criação do McDonalds do que a construção das pirâmides do Egito.',
        1),
    Question(
        'Existem mais átomos no corpo humano do que estrelas no Universo.', 1),
    Question('A asa de um mosquito se move 1000 vezes por segundo.', 1),
    Question(
        'Há mais bactérias em sua boca do que pessoas no planeta Terra.', 1),
    Question(
        'A chance de se ter uma pessoa com uma impressão digital igual a outra é a mesma de ganhar na loteria 50 vezes.',
        2),
    Question(
        'Um estudo comprovou que a comida preferida dos ratos é queijo.', 2),
    Question('O Pernalonga não é um coelho, mas sim uma espécie de lebre.', 1),
    Question('Os golfinhos costumam dar nomes uns aos outros.', 1),
    Question('Foi Napoleão quem destruiu o nariz da esfinge.', 2),
    Question(
        'A grande muralha da China foi construída com o proposito de proteger o império recém unificado.',
        2),
    Question(
        'A miopia é causada por alta exposição à luminosidade das telas dos aparelhos eletrônicos.',
        2),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
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
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
