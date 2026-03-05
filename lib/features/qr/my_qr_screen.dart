import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/flow/app_flow_state.dart';
import '../../core/flow/flow_controller.dart';

class MyQrScreen extends ConsumerWidget {
  const MyQrScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("My QR Code"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(flowProvider.notifier).goTo(AppFlowState.home);
          },
        ),
      ),

      body: const Center(
        child: Icon(
          Icons.qr_code,
          size: 200,
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