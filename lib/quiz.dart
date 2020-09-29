import 'package:flutter/material.dart';
import './question.dart';
import './Answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function addAnswer;

  Quiz({
    @required this.questions,
    @required this.addAnswer,
    @required this.questionIndex,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Question(
          questions[questionIndex]["question"],
        ),
        // Answer(addAnswer),
        // Answer(addAnswer),
        // Answer(addAnswer)
        // ignore: sdk_version_ui_as_code
        ...(questions[questionIndex]["answer"] as List<Map<String, Object>>)
            .map((answers) {
          return Answer(() => addAnswer(answers['score']), answers['text']);
        }).toList()
      ],
    );
  }
}
