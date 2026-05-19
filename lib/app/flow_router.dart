/// lib/app/flow_router.dart
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tally_up/features/history/history_screen.dart';
import 'package:tally_up/features/qr/my_qr_screen.dart';
import 'package:tally_up/features/qr/scan_screen.dart';
import 'package:tally_up/features/send/amount_screen.dart';
import 'package:tally_up/features/send/confirm_screen.dart';
import 'package:tally_up/features/send/recipient_screen.dart';
import 'package:tally_up/features/send/success_screen.dart';

import '../core/providers.dart';
import '../features/account/data/account_state_providers.dart';
import '../core/flow/app_flow_state.dart';
import '../core/flow/flow_controller.dart';
import '../core/navigation/main_shell.dart';
import '../features/auth/presentation/landing_screen.dart';
import '../features/auth/presentation/login_screen.dart';

class FlowRouter extends ConsumerStatefulWidget {
  const FlowRouter({super.key});

  @override
  ConsumerState<FlowRouter> createState() => _FlowRouterState();
}

class _FlowRouterState extends ConsumerState<FlowRouter> {
  bool _bootstrapped = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_bootstrapped) return;
    _bootstrapped = true;

    Future(() async {
      final storage = ref.read(secureStorageProvider);
      final token = await storage.getToken();
      final accountId = await storage.getAccountId();

      if (accountId != null && accountId.isNotEmpty) {
        ref.read(accountIdProvider.notifier).state = accountId;
      }

      if (token != null && token.isNotEmpty) {
        ref.read(flowProvider.notifier).goTo(AppFlowState.home);
      }
      // Otherwise stays on landing
    });
  }

  @override
  Widget build(BuildContext context) {
    final flow = ref.watch(flowProvider);

    switch (flow) {
      case AppFlowState.landing:
        return const LandingScreen();

      case AppFlowState.authLogin:
      case AppFlowState.authOtp:
        return const LoginScreen();

      case AppFlowState.home:
        return const MainShell();

      case AppFlowState.history:
        return const HistoryScreen();

      case AppFlowState.sendRecipient:
        return const RecipientScreen();

      case AppFlowState.sendAmount:
        return const AmountScreen();

      case AppFlowState.sendConfirm:
        return const ConfirmScreen();

      case AppFlowState.sendSuccess:
        return const SuccessScreen();

      case AppFlowState.qrMy:
        return const MyQrScreen();

      case AppFlowState.qrScan:
        return const ScanScreen();
    }
  }
}
