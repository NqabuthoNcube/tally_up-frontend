library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tally_up/core/providers.dart';

import 'auth_remote_data_source.dart';
import 'auth_repository.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return AuthRemoteDataSource(dio);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remote = ref.read(authRemoteDataSourceProvider);
  final storage = ref.read(secureStorageProvider);
  return AuthRepository(remote, storage);
});

