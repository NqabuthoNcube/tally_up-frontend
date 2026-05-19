/// features/send/success_screen.dart
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/flow/app_flow_state.dart';
import '../../core/flow/flow_controller.dart';
import '../../core/theme/app_colors.dart';
import 'data/send_state_providers.dart';

class SuccessScreen extends ConsumerWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amount = ref.read(sendAmountProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Success animation circle
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 600),
                curve: Curves.elasticOut,
                builder: (context, value, child) => Transform.scale(
                  scale: value,
                  child: child,
                ),
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: AppColors.brandGreen.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: AppColors.brandGreen,
                    size: 58,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                'Transfer Successful!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                ),
              ),

              const SizedBox(height: 12),

              if (amount != null)
                Text(
                  'T ${amount.toStringAsFixed(2)} has been sent successfully.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),

              const SizedBox(height: 8),

              Text(
                'The recipient\'s balance will update shortly.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Clear send state
                    ref.read(sendRecipientAccountIdProvider.notifier).state = null;
                    ref.read(sendAmountProvider.notifier).state = null;
                    ref.read(flowProvider.notifier).goTo(AppFlowState.home);
                  },
                  child: const Text('Back to Home'),
                ),
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  ref.read(sendRecipientAccountIdProvider.notifier).state = null;
                  ref.read(sendAmountProvider.notifier).state = null;
                  ref
                      .read(flowProvider.notifier)
                      .goTo(AppFlowState.sendRecipient);
                },
                child: const Text(
                  'Send again',
                  style: TextStyle(color: AppColors.brandGreen),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
