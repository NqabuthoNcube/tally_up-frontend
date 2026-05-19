library;

import 'package:dio/dio.dart';

class AccountRemoteDataSource {
  final Dio dio;

  AccountRemoteDataSource(this.dio);

  Future<Map<String, dynamic>> createAccount(Map<String, dynamic> data) async {
    final response = await dio.post('/accounts', data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> getBalance(String accountId) async {
    final response = await dio.get('/accounts/$accountId/balance');
    return response.data;
  }

  Future<Map<String, dynamic>> getHistory(String accountId, {int page = 1, int pageSize = 20}) async {
    final response = await dio.get(
      '/accounts/$accountId/history',
      queryParameters: {'page': page, 'page_size': pageSize},
    );
    return response.data;
  }
}
