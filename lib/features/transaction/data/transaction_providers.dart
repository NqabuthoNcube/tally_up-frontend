library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tally_up/core/providers.dart';
import 'transaction_remote_data_source.dart';
import 'transaction_repository.dart';

final transactionRemoteDataSourceProvider = Provider<TransactionRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return TransactionRemoteDataSource(dio);
});

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  final remote = ref.read(transactionRemoteDataSourceProvider);
  return TransactionRepository(remote);
});
