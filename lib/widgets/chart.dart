import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import '../widgets/chartbar.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var finalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          finalSum += recentTransaction[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': finalSum,
      };
    }).reversed.toList();
  }

  double get percentageTotal {
    return groupedValues.fold(0.0, (data, index) {
      return data + index['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedValues.map((item) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                item['day'],
                item['amount'],
                percentageTotal == 0.0
                    ? 0.0
                    : (item['amount'] as double) / percentageTotal,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
