/// lib/features/home/home_screen.dart
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/flow/app_flow_state.dart';
import '../../core/flow/flow_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/action_button.dart';
import '../../shared/widgets/balance_card.dart';
import '../../shared/widgets/transaction_tile.dart';
import '../account/data/account_state_providers.dart';
import '../profile/widgets/user_drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(accountBalanceProvider);
    final historyAsync = ref.watch(accountHistoryProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      drawer: const UserDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.brandGreen,
          onRefresh: () async {
            ref.invalidate(accountBalanceProvider);
            ref.invalidate(accountHistoryProvider);
          },
          child: CustomScrollView(
            slivers: [
              // ─── Header ───────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    children: [
                      Builder(
                        builder: (ctx) => GestureDetector(
                          onTap: () => Scaffold.of(ctx).openDrawer(),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.brandGreen.withOpacity(0.12),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person_outline,
                              size: 22,
                              color: AppColors.brandGreen,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Welcome back 👋',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF111827),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications_none_outlined,
                            color: Color(0xFF6B7280)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),

              // ─── Balance Card ──────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: balanceAsync.when(
                    data: (balance) =>
                        BalanceCard(balance: balance.toStringAsFixed(2)),
                    loading: () => const BalanceCard(balance: '—'),
                    error: (e, _) {
                      final isNoAccount = e.toString().contains('No account');
                      return BalanceCard(
                          balance: isNoAccount ? '0.00' : 'Error');
                    },
                  ),
                ),
              ),

              // ─── Action Buttons ────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ActionButton(
                        icon: Icons.send_rounded,
                        label: 'Send',
                        onTap: () => ref
                            .read(flowProvider.notifier)
                            .goTo(AppFlowState.sendRecipient),
                      ),
                      ActionButton(
                        icon: Icons.qr_code_rounded,
                        label: 'Receive',
                        onTap: () => ref
                            .read(flowProvider.notifier)
                            .goTo(AppFlowState.qrMy),
                      ),
                      ActionButton(
                        icon: Icons.qr_code_scanner_rounded,
                        label: 'Scan',
                        onTap: () => ref
                            .read(flowProvider.notifier)
                            .goTo(AppFlowState.qrScan),
                      ),
                      ActionButton(
                        icon: Icons.history_rounded,
                        label: 'History',
                        onTap: () => ref
                            .read(flowProvider.notifier)
                            .goTo(AppFlowState.history),
                      ),
                    ],
                  ),
                ),
              ),

              // ─── Recent Transactions header ────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recent Transactions',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111827),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => ref
                            .read(flowProvider.notifier)
                            .goTo(AppFlowState.history),
                        child: const Text(
                          'See all',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.brandGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ─── Transaction list ──────────────────────────────────
              historyAsync.when(
                data: (txs) {
                  if (txs.isEmpty) {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: _EmptyTransactions(),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final tx = txs[index];
                          final signed =
                              (tx['signed_amount'] as num?)?.toDouble() ?? 0.0;
                          return TransactionTile(
                            name: (tx['transaction_id'] ?? '-').toString(),
                            amount: signed.abs(),
                            incoming: signed > 0,
                            timestamp: DateTime.tryParse(
                                    tx['created_at']?.toString() ?? '') ??
                                DateTime.now(),
                          );
                        },
                        childCount: txs.length,
                      ),
                    ),
                  );
                },
                loading: () => const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 32),
                      child: CircularProgressIndicator(
                        color: AppColors.brandGreen,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                ),
                error: (e, _) => const SliverFillRemaining(
                  hasScrollBody: false,
                  child: _EmptyTransactions(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyTransactions extends StatelessWidget {
  const _EmptyTransactions();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.brandGreen.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.receipt_long_outlined,
                color: AppColors.brandGreen,
                size: 34,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No transactions yet',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xFF374151),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Send or receive money to see\nyour activity here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
