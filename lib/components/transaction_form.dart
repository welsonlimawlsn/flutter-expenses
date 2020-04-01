import 'dart:math';

import 'package:expenses/models/transaction.dart';
import 'package:expenses/util/date_util.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(Transaction) onCreated;

  TransactionForm({this.onCreated});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitForm() {
    var transaction = Transaction(
        id: Random().nextDouble().toString(),
        date: _selectedDate,
        value: double.tryParse(_valueController.text) ?? 0,
        title: _titleController.text);

    if (transaction.isInvalid()) {
      return;
    }

    widget.onCreated(transaction);
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1970),
            lastDate: DateTime.now())
        .then((date) {
      if (date != null) {
        setState(() {
          _selectedDate = date;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Título'),
              controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _valueController,
              onSubmitted: (_) => _submitForm(),
            ),
            Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      _selectedDate == null
                          ? 'Nenhuma data selecionada'
                          : DateUtil.toPtBr(_selectedDate),
                      style: Theme.of(context).textTheme.subhead),
                  IconButton(
                    onPressed: _showDatePicker,
                    icon: Icon(Icons.calendar_today),
                    color: Theme.of(context).primaryColor,
                    tooltip: 'Selecionar data',
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  child: Text('Nova transação'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  onPressed: _submitForm,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
