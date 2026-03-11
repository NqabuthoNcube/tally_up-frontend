/// lib/features/history/presentation/history_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/flow/app_flow_state.dart';
import '../../core/flow/flow_controller.dart';
import '../../shared/widgets/transaction_tile.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = [
      {
        "name": "Kudzaiishe Nyenza",
        "amount": 250,
        "incoming": true,
        "time": DateTime.now()
      },
      {
        "name": "Tashinga Bwanali",
        "amount": 100,
        "incoming": false,
        "time": DateTime.now()
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(flowProvider.notifier).goTo(AppFlowState.home);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final tx = transactions[index];

          return TransactionTile(
            name: tx["name"] as String,
            amount: tx["amount"] as num,
            incoming: tx["incoming"] as bool,
            timestamp: tx["time"] as DateTime,
          );
        },
      ),
    );
  }
}