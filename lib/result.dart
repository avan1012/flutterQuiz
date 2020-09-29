import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;
  final Function resetQuiz;
  Result(this.totalScore, this.resetQuiz);

  String get resultState {
    String resultText;
    if (totalScore <= 8) {
      resultText = 'you are awesome.';
    } else if (totalScore <= 12) {
      resultText = 'you are innocent.';
    } else if (totalScore <= 16) {
      resultText = 'you are strange.';
    } else {
      resultText = "You are so bad";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
            child: Text(
              resultState,
              style: TextStyle(
                  color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: FlatButton(
              child: Text('Reset Quiz.'),
              color: Colors.blueAccent,
              textColor: Colors.white,
              onPressed: resetQuiz,
            ),
          ),
        ],
      ),
    );
  }
}
