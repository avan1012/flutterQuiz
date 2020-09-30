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
import './widgets/newtransaction.dart';
import './widgets/transactionlist.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.amber,
          accentColor: Colors.yellow,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )))),
      title: 'Personal Expenses',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> userTransction = [
    // Transaction(
    //   id: 't1',
    //   title: 'Shoes',
    //   amount: 25.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Mobiles',
    //   amount: 125.99,
    //   date: DateTime.now(),
    // )
  ];

  List<Transaction> get _recentTransactions {
    return userTransction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransctions(String title, double amount) {
    final newdata = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );

    setState(() {
      userTransction.add(newdata);
    });
  }

  void _addNewTransactions(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addTransctions),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Personal Expenses'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _addNewTransactions(context)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Chart(_recentTransactions),
              TransactionList(userTransction),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _addNewTransactions(context),
        ),
      ),
    );
  }
}
