import 'package:expenses/models/transaction.dart';
import 'package:expenses/util/date_util.dart';
import 'package:expenses/util/number_util.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  final void Function(Transaction) onRemoveTransaction;

  TransactionList(this.transactions, {this.onRemoveTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? buildEmptyList(context)
          : buildListView(context),
    );
  }

  ListView buildListView(BuildContext context) {
    return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          Transaction transaction = transactions[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: FittedBox(
                    child: Text(NumberUtil.toCurrency(transaction.value)),
                  ),
                ),
              ),
              title: Text(transaction.title),
              subtitle: Text(DateUtil.toPtBr(transaction.date)),
              trailing: IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () => onRemoveTransaction(transaction),
              ),
            ),
          );
        });
  }

  Column buildEmptyList(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'Nenhuma transação cadastrada',
            style: Theme.of(context).textTheme.title,
          ),
        ),
        Container(
          height: 200,
          child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
