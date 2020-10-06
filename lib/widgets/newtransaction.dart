import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './adaptive_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;
  NewTransaction(this.addtx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void add() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }

    widget.addtx(
      enteredTitle,
      enteredAmount,
      selectedDate,
    );

    Navigator.of(context).pop();
  }

  void presentShowPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                controller: titleController,
                onSubmitted: (_) => add(),
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: amountController,
                onSubmitted: (_) => add(),
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      selectedDate == null
                          ? 'No Date Chosen!!!!'
                          : 'Picked Date : ${DateFormat.yMd().format(selectedDate)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    AdaptiveButton('Choose Date', presentShowPicker)
                    // Platform.isIOS
                    //     ? CupertinoButton(
                    //         onPressed: presentShowPicker,
                    //         color: Colors.purple,
                    //         child: Text('Choose Date'),
                    //       )
                    //     : FlatButton(
                    //         onPressed: presentShowPicker,
                    //         textColor: Colors.purple,
                    //         child: Text('Choose Date'),
                    //       ),
                    // RaisedButton(
                    //   onPressed: presentShowPicker,
                    //   color: Colors.purple,
                    //   child: Text('Choose Date'),
                    // )
                  ],
                ),
              ),
              RaisedButton(
                onPressed: add,
                color: Colors.purple,
                child: Text('Add Transaction'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
