/// features/send/presentation/recipient_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/flow/app_flow_state.dart';
import '../../core/flow/flow_controller.dart';

class RecipientScreen extends ConsumerWidget {
  const RecipientScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Recipient"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              ref.read(flowProvider.notifier).goTo(AppFlowState.home),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Tendai Moyo"),
            subtitle: const Text("TU-4421-87"),
            onTap: () =>
                ref.read(flowProvider.notifier).goTo(AppFlowState.sendAmount),
          ),
          ListTile(
            title: const Text("Samu Khumalo"),
            subtitle: const Text("TU-8834-02"),
            onTap: () =>
                ref.read(flowProvider.notifier).goTo(AppFlowState.sendAmount),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.home),
        onPressed: () =>
            ref.read(flowProvider.notifier).goTo(AppFlowState.home),
      ),
    );
  }
}