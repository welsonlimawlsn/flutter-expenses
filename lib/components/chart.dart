import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:expenses/util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  double _weekTotalValue;

  Chart(this.transactions) {
    _weekTotalValue = sumWeekTotalValue();
  }

  List<Map<String, Object>> get _groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double sum = transactions
          .where((transaction) =>
              DateUtil.trunc(transaction.date) == DateUtil.trunc(weekDay))
          .map((transaction) => transaction.value)
          .fold(0, (previous, current) => previous + current);
      return {
        'day': DateFormat.E('pt-br').format(weekDay)[0].toUpperCase(),
        'value': sum,
        'percentage': _weekTotalValue > 0 ? sum / _weekTotalValue : 0.0
      };
    }).reversed.toList();
  }

  double sumWeekTotalValue() {
    return transactions
        .map((transaction) => transaction.value)
        .fold(0, (previous, current) => previous + current);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedTransactions
              .map((transaction) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      label: transaction['day'],
                      value: transaction['value'],
                      percentage: transaction['percentage'],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
