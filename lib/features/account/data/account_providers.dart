library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tally_up/core/providers.dart';
import 'account_remote_data_source.dart';
import 'account_repository.dart';

final accountRemoteDataSourceProvider = Provider<AccountRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return AccountRemoteDataSource(dio);
});

final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  final remote = ref.read(accountRemoteDataSourceProvider);
  return AccountRepository(remote);
});
