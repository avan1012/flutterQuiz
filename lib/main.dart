// import 'package:flutter/material.dart';
// import './quiz.dart';
// import './result.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return MyAppState();
//   }
// }

// class MyAppState extends State<MyApp> {
//   var questionIndex = 0;
//   var totalScore = 0;

//   void resetQuiz() {
//     setState(() {
//       questionIndex = 0;
//       totalScore = 0;
//     });
//   }

//   void addAnswer(int score) {
//     totalScore += score;
//     setState(() {
//       questionIndex = questionIndex + 1;
//     });
//   }

//   Widget build(BuildContext context) {
//     var questions = [
//       {
//         'question': 'what is your favourite color?',
//         'answer': [
//           {"text": 'Red', "score": 10},
//           {"text": 'Blue', "score": 5},
//           {"text": 'Green', "score": 2}
//         ]
//       },
//       {
//         'question': 'what is your favourite animal?',
//         'answer': [
//           {"text": 'Rabbit', "score": 10},
//           {"text": 'Dog', "score": 5},
//           {"text": 'Cat', "score": 2}
//         ]
//       },
//       {
//         'question': 'what is your favourite programming language?',
//         'answer': [
//           {"text": 'c', "score": 10},
//           {"text": 'c++', "score": 5},
//           {"text": 'java', "score": 2}
//         ]
//       },
//       {
//         'question': 'what is your favourite language?',
//         'answer': [
//           {"text": 'Hindi', "score": 10},
//           {"text": 'Gujarati', "score": 5},
//           {"text": 'English', "score": 2}
//         ]
//       },
//     ];
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('My first Quiz app'),
//         ),
//         body: questionIndex < questions.length
//             ? Quiz(
//                 addAnswer: addAnswer,
//                 questions: questions,
//                 questionIndex: questionIndex)
//             : Result(totalScore, resetQuiz),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tutorial',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transaction = [
    Transaction(
      id: 't1',
      title: 'Shoes',
      amount: 25.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Mobiles',
      amount: 125.99,
      date: DateTime.now(),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              color: Colors.red,
              child: Container(
                width: double.infinity,
                child: Text('Chart'),
              ),
              elevation: 5,
            ),
            Column(
              children: transaction.map((item) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Text(
                          '\$' + '${item.amount}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.purple,
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.purple,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.,
                        children: <Widget>[
                          Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            item.date.toString(),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
