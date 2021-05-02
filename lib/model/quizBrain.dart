import 'question.dart';

class Quizbrain {
  int _questionNumber = 0;

  List<Question> ngQuestionBank = [
    Question.name("Nigeria won the 2010 World Cup.", false),
    Question.name("Kwara United has won the most trophies of any club in Nigeria", false),
    Question.name("Nigeria's National Stadium is located in Abuja", true),
    Question.name("Nigeria has won five AFCON titles.", false),
    Question.name("Jay Jay Okocha has never won the CAF African Player of the Year award", true),
  ];

  void nextQuestion() {
    if (_questionNumber < ngQuestionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return ngQuestionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return ngQuestionBank[_questionNumber].isRight;
  }


  bool isFinished() {
    if (_questionNumber >= ngQuestionBank.length - 1) {

      print('Now returning true');
      return true;

    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}




