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
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/newtransaction.dart';
import './widgets/transactionlist.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

// void main() => runApp(MyApp());
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ],
  // );
  runApp(MyApp());
}

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
      title: 'Personal Expense',
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

  bool isChanged = false;

  List<Transaction> get _recentTransactions {
    return userTransction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransctions(String title, double amount, DateTime chosenDate) {
    final newdata = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
    );

    setState(() {
      userTransction.add(newdata);
    });
  }

  void _addNewTransactions(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
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

  void deleteTransaction(String id) {
    // userTransction.removeWhere((tx) => tx.id == id);
    setState(() {
      userTransction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final orientation = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appbar = Platform.isAndroid
        ? AppBar(
            title: Text('Personal Expenses'),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _addNewTransactions(context)),
            ],
          )
        : CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _addNewTransactions(context),
                )
              ],
            ),
          );
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appbar.preferredSize.height -
              mediaQuery.padding.top) *
          0.75,
      child: TransactionList(userTransction, deleteTransaction),
    );

    final body = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (orientation)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FittedBox(
                    child: Text(
                      'Show chart.',
                      style: TextStyle(
                          color: Colors.orange, fontFamily: 'Quicksand-bold'),
                    ),
                  ),
                  Switch.adaptive(
                    activeColor: Colors.blueAccent,
                    value: isChanged,
                    onChanged: (val) {
                      setState(() {
                        isChanged = val;
                      });
                    },
                  )
                ],
              ),
            if (!orientation)
              Container(
                margin: EdgeInsets.all(10),
                height: (mediaQuery.size.height -
                        appbar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            if (!orientation) txListWidget,
            if (orientation)
              isChanged
                  ? Container(
                      margin: EdgeInsets.all(10),
                      height: (mediaQuery.size.height -
                              appbar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(_recentTransactions),
                    )
                  : txListWidget
          ],
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Platform.isIOS
          ? CupertinoPageScaffold(
              child: body,
              navigationBar: appbar,
            )
          : Scaffold(
              appBar: appbar,
              body: body,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Platform.isAndroid
                  ? FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () => _addNewTransactions(context),
                    )
                  : Container(),
            ),
    );
  }
}
