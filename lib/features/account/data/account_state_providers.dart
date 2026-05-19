import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'account_providers.dart';

final accountIdProvider = StateProvider<String?>((ref) => null);

final accountBalanceProvider = FutureProvider<double>((ref) async {
  final repo = ref.read(accountRepositoryProvider);
  final accountId = ref.watch(accountIdProvider);
  if (accountId == null || accountId.isEmpty) {
    throw Exception('No account ID — please log in');
  }
  final data = await repo.getBalance(accountId);
  final raw = data['balance'];
  if (raw == null) throw Exception('Balance missing from response');
  return (raw as num).toDouble();
});

final accountHistoryProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final repo = ref.read(accountRepositoryProvider);
  final accountId = ref.watch(accountIdProvider);
  if (accountId == null || accountId.isEmpty) {
    throw Exception('No account ID — please log in');
  }
  final data = await repo.getHistory(accountId, page: 1, pageSize: 20);
  final items = data['items'];
  if (items == null) return [];
  return (items as List).cast<Map<String, dynamic>>();
});

