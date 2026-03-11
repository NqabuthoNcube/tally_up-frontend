/// features/send/presentation/confirm_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/flow/app_flow_state.dart';
import '../../core/flow/flow_controller.dart';

class ConfirmScreen extends ConsumerWidget {
  const ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Transfer"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => ref
              .read(flowProvider.notifier)
              .goTo(AppFlowState.sendAmount),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Recipient: Samu Khumalo"),
            SizedBox(height: 10),
            Text("Amount: 150 TLY"),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () =>
              ref.read(flowProvider.notifier).goTo(AppFlowState.sendSuccess),
          child: const Text("Confirm & Send"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.home),
        onPressed: () =>
            ref.read(flowProvider.notifier).goTo(AppFlowState.home),
      ),
    );
  }
}