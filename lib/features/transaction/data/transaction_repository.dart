library;

import 'transaction_remote_data_source.dart';

class TransactionRepository {
  final TransactionRemoteDataSource _remote;

  TransactionRepository(this._remote);

  Future<Map<String, dynamic>> transfer(Map<String, dynamic> data) async {
    return await _remote.transfer(data);
  }
}
