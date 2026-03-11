/// lib/features/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/flow/app_flow_state.dart';
import '../../core/flow/flow_controller.dart';

import '../../shared/widgets/action_button.dart';
import '../../shared/widgets/balance_card.dart';
import '../../shared/widgets/transaction_tile.dart';

import '../profile/widgets/user_drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentTransactions = [
      {
        "name": "Tendai Moyo",
        "amount": 250,
        "incoming": true,
        "time": DateTime.now()
      },
      {
        "name": "Samu Khumalo",
        "amount": 100,
        "incoming": false,
        "time": DateTime.now()
      },
    ];

    return Scaffold(
      drawer: const UserDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              /// HEADER
              Row(
                children: [
                  Builder(
                    builder: (context) => GestureDetector(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: const CircleAvatar(
                        radius: 18,
                        child: Icon(Icons.person, size: 20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Welcome",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// BALANCE
              const BalanceCard(balance: "1240"),

              const SizedBox(height: 30),

              /// ACTION BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ActionButton(
                    icon: Icons.send,
                    label: "Send",
                    onTap: () {
                      ref
                          .read(flowProvider.notifier)
                          .goTo(AppFlowState.sendRecipient);
                    },
                  ),

                  ActionButton(
                    icon: Icons.qr_code,
                    label: "Receive",
                    onTap: () {
                      ref
                          .read(flowProvider.notifier)
                          .goTo(AppFlowState.qrMy);
                    },
                  ),

                  ActionButton(
                    icon: Icons.qr_code_scanner,
                    label: "Scan",
                    onTap: () {
                      ref
                          .read(flowProvider.notifier)
                          .goTo(AppFlowState.qrScan);
                    },
                  ),

                  ActionButton(
                    icon: Icons.history,
                    label: "History",
                    onTap: () {
                      ref
                          .read(flowProvider.notifier)
                          .goTo(AppFlowState.history);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Recent Transactions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: recentTransactions.length,
                  itemBuilder: (context, index) {
                    final tx = recentTransactions[index];

                    return TransactionTile(
                      name: tx["name"] as String,
                      amount: tx["amount"] as num,
                      incoming: tx["incoming"] as bool,
                      timestamp: tx["time"] as DateTime,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}