import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  TransactionList(this.userTransction, this.deleteData);
  List<Transaction> userTransction;
  final Function deleteData;
  // final List<Transaction> userTransction = [
  //   Transaction(
  //     id: 't1',
  //     title: 'Shoes',
  //     amount: 25.99,
  //     date: DateTime.now(),
  //   ),
  //   Transaction(
  //     id: 't2',
  //     title: 'Mobiles',
  //     amount: 125.99,
  //     date: DateTime.now(),
  //   )
  // ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: userTransction.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No Transactions Found!!!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    // 'https://picsum.photos/250?image=9',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${userTransction[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      userTransction[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(userTransction[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: 30,
                        color: Colors.red,
                      ),
                      onPressed: () => deleteData(userTransction[index].id),
                    ),
                  ),
                );
                // return Card(
                //   child: Row(
                //     children: <Widget>[
                //       Container(
                //         margin:
                //             EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                //         child: Text(
                //           '\$' +
                //               '${userTransction[index].amount.toStringAsFixed(2)}',
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 20,
                //             color: Theme.of(context).primaryColor,
                //           ),
                //         ),
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             color: Theme.of(context).primaryColor,
                //             width: 2,
                //           ),
                //         ),
                //         padding: EdgeInsets.all(10),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         // mainAxisAlignment: MainAxisAlignment.,
                //         children: <Widget>[
                //           Text(
                //             userTransction[index].title,
                //             style: Theme.of(context).textTheme.title,
                //           ),
                //           Text(
                //             DateFormat('yyyy-MM-dd')
                //                 .format(userTransction[index].date),
                //             // item.date.toString(),
                //             style: TextStyle(
                //               color: Colors.grey,
                //             ),
                //           )
                //         ],
                //       )
                //     ],
                //   ),
                // );
              },
              itemCount: userTransction.length,
            ),
    );
  }
}
