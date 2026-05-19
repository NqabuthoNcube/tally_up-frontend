/// features/send/confirm_screen.dart
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/flow/app_flow_state.dart';
import '../../core/flow/flow_controller.dart';
import '../../core/theme/app_colors.dart';
import '../account/data/account_state_providers.dart';
import '../transaction/data/transaction_providers.dart';
import 'data/send_state_providers.dart';

class ConfirmScreen extends ConsumerStatefulWidget {
  const ConfirmScreen({super.key});

  @override
  ConsumerState<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends ConsumerState<ConfirmScreen> {
  bool _loading = false;
  String? _error;

  Future<void> _confirm() async {
    final senderAccountId = ref.read(accountIdProvider);
    final receiverAccountId = ref.read(sendRecipientAccountIdProvider);
    final amount = ref.read(sendAmountProvider);

    if (senderAccountId == null || receiverAccountId == null || amount == null) {
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final repo = ref.read(transactionRepositoryProvider);
      final idempotencyKey = const Uuid().v4();

      await repo.transfer({
        'sender_account_id': senderAccountId,
        'receiver_account_id': receiverAccountId,
        'amount': amount,
        'reference': 'mobile_transfer',
        'idempotency_key': idempotencyKey,
      });

      ref.invalidate(accountBalanceProvider);
      ref.invalidate(accountHistoryProvider);
      ref.read(flowProvider.notifier).goTo(AppFlowState.sendSuccess);
    } catch (e) {
      setState(() {
        _error = _friendly(e);
        _loading = false;
      });
    }
  }

  String _friendly(Object e) {
    final msg = e.toString();
    if (msg.contains('400')) return 'Invalid transfer request. Check the details.';
    if (msg.contains('402') || msg.contains('insufficient')) {
      return 'Insufficient balance for this transfer.';
    }
    if (msg.contains('404')) return 'Recipient account not found.';
    if (msg.contains('connection') || msg.contains('Socket')) {
      return 'Connection error. Check your internet.';
    }
    return 'Transfer failed. Please try again.';
  }

  @override
  Widget build(BuildContext context) {
    final senderAccountId = ref.watch(accountIdProvider);
    final receiverAccountId = ref.watch(sendRecipientAccountIdProvider);
    final amount = ref.watch(sendAmountProvider);
    final canSend =
        senderAccountId != null && receiverAccountId != null && amount != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () =>
              ref.read(flowProvider.notifier).goTo(AppFlowState.sendAmount),
        ),
        title: const Text(
          'Confirm Transfer',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Step indicator (full)
            Row(
              children: List.generate(3, (i) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: i < 2 ? 6 : 0),
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.brandGreen,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 32),

            // Amount display
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.brandGreen, AppColors.brandGreenDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Text(
                    'Sending',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'T ${amount?.toStringAsFixed(2) ?? '0.00'}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 44,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Details card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _DetailRow(
                    label: 'From',
                    value: _truncate(senderAccountId ?? '—'),
                    icon: Icons.account_balance_wallet_outlined,
                  ),
                  const Divider(height: 24),
                  _DetailRow(
                    label: 'To',
                    value: _truncate(receiverAccountId ?? '—'),
                    icon: Icons.person_outline,
                  ),
                  const Divider(height: 24),
                  const _DetailRow(
                    label: 'Note',
                    value: 'Transfers are idempotent — retries won\'t duplicate.',
                    icon: Icons.info_outline,
                    small: true,
                  ),
                ],
              ),
            ),

            if (_error != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline,
                        color: AppColors.error, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _error!,
                        style: const TextStyle(
                            color: AppColors.error, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (!canSend || _loading) ? null : _confirm,
                child: _loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                      )
                    : const Text('Confirm & Send'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _truncate(String id) {
    if (id.length > 20) return '${id.substring(0, 8)}...${id.substring(id.length - 6)}';
    return id;
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final bool small;

  const _DetailRow({
    required this.label,
    required this.value,
    required this.icon,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.brandGreen, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: small ? 12 : 14,
                  color: small ? Colors.grey.shade500 : const Color(0xFF111827),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
