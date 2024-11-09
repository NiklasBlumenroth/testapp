import 'package:flutter/material.dart';

class OverviewSection extends StatelessWidget {
  final int workerCount;
  final List<Map<String, dynamic>> transactionLog;
  final Function(int) onRemoveTransaction;

  OverviewSection({
    required this.workerCount,
    required this.transactionLog,
    required this.onRemoveTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anzahl der Arbeiter: $workerCount',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text(
          'Aktivitäten',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: ListView.builder(
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
          ),
        ),
      ],
    );
  }
}
