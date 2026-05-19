library;

import 'package:dio/dio.dart';

class TransactionRemoteDataSource {
  final Dio dio;

  TransactionRemoteDataSource(this.dio);

  Future<Map<String, dynamic>> transfer(Map<String, dynamic> data) async {
    final response = await dio.post('/transactions/transfer', data: data);
    return response.data;
  }
}
