import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {

  final String name;
  final int amount;
  final bool incoming;

  const TransactionTile({
    super.key,
    required this.name,
    required this.amount,
    required this.incoming,
  });

  @override
  Widget build(BuildContext context) {

    return ListTile(

      leading: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.teal.shade100,
        child: Text(
          name[0],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      title: Text(name),

      trailing: Text(
        "${incoming ? "+" : "-"}$amount",
        style: TextStyle(
          color: incoming ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}