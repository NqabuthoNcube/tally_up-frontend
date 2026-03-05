import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/flow/app_flow_state.dart';
import '../core/flow/flow_controller.dart';

import '../features/auth/otp_screen.dart';
import '../features/send/recipient_screen.dart';
import '../features/send/amount_screen.dart';
import '../features/send/confirm_screen.dart';
import '../features/send/success_screen.dart';
import '../features/history/history_screen.dart';
import '../features/qr/my_qr_screen.dart';
import '../features/qr/scan_screen.dart';
import '../core/navigation/main_shell.dart';

class FlowRouter extends ConsumerWidget {
  const FlowRouter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flow = ref.watch(flowProvider);

    switch (flow) {
      case AppFlowState.authOtp:
        return const OtpScreen();

      case AppFlowState.home:
        return const MainShell();

      case AppFlowState.sendRecipient:
        return const RecipientScreen();

      case AppFlowState.sendAmount:
        return const AmountScreen(recipient: '',);

      case AppFlowState.sendConfirm:
        return const ConfirmScreen();

      case AppFlowState.sendSuccess:
        return const SuccessScreen();

      case AppFlowState.history:
        return const HistoryScreen();

      case AppFlowState.qrMy:
        return const MyQrScreen();

      case AppFlowState.qrScan:
        return const ScanScreen();

      default:
        return const OtpScreen();
    }
  }
}