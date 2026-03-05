import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/flow/app_flow_state.dart';
import '../../core/flow/flow_controller.dart';
import '../../core/widgets/transaction_tile.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Transaction History"),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),

          // GO BACK TO HOME
          onPressed: () {
            ref.read(flowProvider.notifier)
                .goTo(AppFlowState.home);
          },
        ),

        actions: [

          IconButton(
            icon: const Icon(Icons.home),

            // HOME BUTTON
            onPressed: () {
              ref.read(flowProvider.notifier)
                  .goTo(AppFlowState.home);
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: ListView(
          children: const [

            TransactionTile(
              name: "Tendai Moyo",
              amount: 250,
              incoming: true,
            ),

             TransactionTile(
              name: "Samu Khumalo",
              amount: 100,
              incoming: false,
            ),

             TransactionTile(
              name: "Nyasha Dube",
              amount: 400,
              incoming: true,
            ),
          ],
        ),
      ),
    );
  }
}