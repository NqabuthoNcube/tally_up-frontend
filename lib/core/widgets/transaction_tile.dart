/// shared/widgets/transaction_tile.dart

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
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

    final color = incoming ? AppColors.success : AppColors.error;
    final sign = incoming ? "+" : "-";

    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: color.withOpacity(0.15),
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : "?",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
      title: Text(
        name,
        style: theme.textTheme.bodyLarge,
      ),
      subtitle: timestamp != null
          ? Text(
              _formatTime(timestamp!),
              style: theme.textTheme.bodySmall,
            )
          : null,
      trailing: Text(
        "$sign${CurrencyFormatter.format(amount)}",
        style: theme.textTheme.bodyMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }
}