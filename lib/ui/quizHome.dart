import 'dart:ui';
import 'package:my_quiz_app/model/quizBrain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

Quizbrain quizbrain = Quizbrain();


class Quiz extends StatefulWidget {
  final int score;
  final int count;
  final int finalscore;
  final String name;

  const Quiz({Key key, this.score, this.count, this.finalscore, this.name})
      : super(key: key);
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int _currentQuestionIndex = 1;
  int _totalScore = 0;
  double _progress = 0.0;
  //var _totalBarIndent;
  List<Icon> scoreKeeper = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("The Nigerian",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Builder(
        builder: (BuildContext context) => Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset(
                  "images/nigeria_flag.png",
                  width: 220,
                  height: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                        color: Colors.green, style: BorderStyle.solid),
                  ),
                  height: 120.0,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${quizbrain.ngQuestionBank[_currentQuestionIndex].questionText}",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 17.0,
                            color: Colors.grey.shade700),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => _checkAnswer(true, context),
                    color: Colors.green,
                    splashColor: Colors.green.shade300,
                    child: Text(
                      "True",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () => _checkAnswer(false, context),
                    color: Colors.green,
                    splashColor: Colors.green.shade300,
                    child: Text(
                      "False",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  _nextButtonEnd(),
                ],
              ),
              Expanded(
                  child: Row(
                    children: scoreKeeper,
                  )),
              Spacer(),
              Divider(
                thickness: 2.0,
                color: Colors.green,
                indent: _progressBar(),
                endIndent: 36.6,
              ),
              //
            ],
          ),
        ),
      ),
    );
  }

  void getCategory(String category) {

  }
  void _navigateToScore() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => MyQuizScore(
            score: ((_totalScore * 100) / (quizbrain.ngQuestionBank.length - 2)).floor(),
            count: quizbrain.ngQuestionBank.length - 2,
            finalscore: _totalScore)));
  }

  _checkAnswer(bool userChoice, BuildContext context) {
    setState(() {
      if (userChoice == quizbrain.ngQuestionBank[_currentQuestionIndex].isRight) {
        final assetsAudioPlayer = AssetsAudioPlayer();
        assetsAudioPlayer.open(
          Audio("audio/correct.mp3"),
        );
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
        final snackbar = SnackBar(
            backgroundColor: Colors.green,
            duration: Duration(milliseconds: 800),
            content: Text("Correct!"));
        Scaffold.of(context).showSnackBar(snackbar);
        //debugPrint("Correct");
        _updateQuestion();
        //_checkLastQuestion();
        _calculateTotalScore();
      } else {
        final assetsAudioPlayer = AssetsAudioPlayer();
        assetsAudioPlayer.open(
          Audio("audio/incorrect.mp3"),
        );
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
        final snackbar = SnackBar(
            backgroundColor: Colors.redAccent,
            duration: Duration(milliseconds: 800),
            content: Text("Incorrect!"));
        Scaffold.of(context).showSnackBar(snackbar);
        //debugPrint("Wrong");
        _updateQuestion();
        //_checkLastQuestion();
      }
    });
    _endQuiz();
  }

  _endQuiz() {
    if (_currentQuestionIndex == quizbrain.ngQuestionBank.length - 1) {
      _navigateToScore();
    }
  }

  _nextButtonEnd() {
    if (_currentQuestionIndex == quizbrain.ngQuestionBank.length - 2) {
      return RaisedButton(
          onPressed: () => _navigateToScore(),
          color: Colors.green,
          splashColor: Colors.green.shade300,
          child: Text(
            "End",
            style: TextStyle(
              color: Colors.white,
            ),
          ));
    } else {
      return RaisedButton(
          onPressed: () => _nextQuestion(),
          color: Colors.green,
          splashColor: Colors.green.shade300,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ));
    }
  }

  _calculateTotalScore() {
    setState(() {
      _totalScore += 1;
    });
  }

  _updateQuestion() {
    setState(() {
      _currentQuestionIndex =
          (_currentQuestionIndex + 1) % quizbrain.ngQuestionBank.length;
    });
  }

  _nextQuestion() {
    setState(() {
      final assetsAudioPlayer = AssetsAudioPlayer();
      assetsAudioPlayer.open(Audio("audio/chicken.mp3"));
      _updateQuestion();
      //_checkLastQuestion();
    });
  }

  double _progressBar() {
    _progress = ((_currentQuestionIndex / quizbrain.ngQuestionBank.length) * 100) * 4;
    debugPrint(_progress.toString());
    return _progress;
  }

}


class MyQuizScore extends StatelessWidget {
  final int score;
  final int count;
  final int finalscore;

  const MyQuizScore({Key key, this.score, this.count, this.finalscore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("The Nigerian",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      ""
                          "Your Score",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.green, shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            "${this.score}%",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),

                    Text("Congratulations!!!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0)),
                  ],
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

















