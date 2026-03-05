import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/flow/app_flow_state.dart';
import '../../core/flow/flow_controller.dart';

class AmountScreen extends ConsumerWidget {
  const AmountScreen({super.key, required String recipient});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Amount"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(flowProvider.notifier)
                .goTo(AppFlowState.sendRecipient);
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

            const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Amount",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                ref.read(flowProvider.notifier)
                    .goTo(AppFlowState.sendConfirm);
              },
              child: const Text("Continue"),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.home),
        onPressed: () {
          ref.read(flowProvider.notifier).goTo(AppFlowState.home);
        },
      ),
    );
  }
}