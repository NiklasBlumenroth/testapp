import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Map<String, dynamic>> transactionLog;
  final Function(int) onRemoveTransaction;

  TransactionList({required this.transactionLog, required this.onRemoveTransaction});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactionLog.length,
      itemBuilder: (context, index) {
        final transaction = transactionLog[index];
        return ListTile(
          title: Text('${transaction['level']} - ${transaction['action']}'),
          subtitle: Text(
            'Kosten: ${transaction['cost']}€ - ${transaction['time'].toString().substring(0, 16)}',
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () => onRemoveTransaction(index),
          ),
        );
      },
    );
  }
}
