/// shared/widgets/transaction_tile.dart

import 'package:flutter/material.dart';
import '../../core/utils/currency_formatter.dart';

class TransactionTile extends StatelessWidget {
  final String name;
  final num amount;
  final bool incoming;
  final DateTime? timestamp;

  const TransactionTile({
    super.key,
    required this.name,
    required this.amount,
    required this.incoming,
    this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final color = incoming ? Colors.green : Colors.red;
    final sign = incoming ? "+" : "-";

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.15),
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : "?",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
      title: Text(name),
      subtitle: timestamp != null
          ? Text(
              _formatTime(timestamp!),
              style: theme.textTheme.bodySmall,
            )
          : null,
      trailing: Text(
        "$sign${CurrencyFormatter.format(amount)}",
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    return "$h:$m";
  }
}