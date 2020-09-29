import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function addEventHandler;
  final String answerText;

  Answer(this.addEventHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        textColor: Colors.white,
        color: Colors.blueAccent,
        child: Text(answerText),
        onPressed: addEventHandler,
      ),
    );
  }
}
