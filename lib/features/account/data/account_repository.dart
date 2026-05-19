library;

import 'account_remote_data_source.dart';

class AccountRepository {
  final AccountRemoteDataSource _remote;

  AccountRepository(this._remote);

  Future<Map<String, dynamic>> createAccount(Map<String, dynamic> data) async {
    return await _remote.createAccount(data);
  }

  Future<Map<String, dynamic>> getBalance(String accountId) async {
    return await _remote.getBalance(accountId);
  }

  Future<Map<String, dynamic>> getHistory(String accountId, {int page = 1, int pageSize = 20}) async {
    return await _remote.getHistory(accountId, page: page, pageSize: pageSize);
  }
}
