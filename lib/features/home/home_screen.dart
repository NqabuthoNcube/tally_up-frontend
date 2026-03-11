import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/balance_card.dart';
import '../../core/widgets/action_button.dart';
import '../../core/widgets/transaction_tile.dart';

import '../../core/flow/app_flow_state.dart';
import '../../core/flow/flow_controller.dart';

import '../../core/services/whatsapp_service.dart';
import '../profile/widgets/user_drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      /// LEFT USER DRAWER
      drawer: const UserDrawer(),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER BAR
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      /// PROFILE → OPENS DRAWER
                      Builder(
                        builder: (context) => GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: const CircleAvatar(
                            radius: 18,
                            child: Icon(Icons.person, size: 20),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      const Text(
                        "Good Morning",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  /// WHATSAPP BOT BUTTON
                  IconButton(
                    icon: const Icon(Icons.message),
                    onPressed: () {
                      WhatsAppService.openBot();
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// BALANCE CARD
              const BalanceCard(balance: "1,240"),

              const SizedBox(height: 30),

              /// QUICK ACTION BUTTONS
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
                      ref.read(flowProvider.notifier).goTo(AppFlowState.qrMy);
                    },
                  ),
                  ActionButton(
                    icon: Icons.qr_code_scanner,
                    label: "Scan",
                    onTap: () {
                      ref.read(flowProvider.notifier).goTo(AppFlowState.qrScan);
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

              /// TRANSACTIONS HEADER
              const Text(
                "Recent Transactions",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              /// TRANSACTION LIST
              Expanded(
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
            ],
          ),
        ),
      ),
    );
  }
}
