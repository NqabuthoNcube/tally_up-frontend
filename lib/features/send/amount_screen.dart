/// features/send/presentation/amount_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/flow/app_flow_state.dart';
import '../../core/flow/flow_controller.dart';

class AmountScreen extends ConsumerStatefulWidget {
  final String recipient;

  const AmountScreen({
    super.key,
    required this.recipient,
  });

  @override
  ConsumerState<AmountScreen> createState() => _AmountScreenState();
}

class _AmountScreenState extends ConsumerState<AmountScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _continue() {
    final value = controller.text.trim();

    if (value.isEmpty) return;

    ref.read(flowProvider.notifier).goTo(AppFlowState.sendConfirm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send to ${widget.recipient}"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              ref.read(flowProvider.notifier).goTo(AppFlowState.sendRecipient),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Amount",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _continue,
              child: const Text("Continue"),
            ),
          ],
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