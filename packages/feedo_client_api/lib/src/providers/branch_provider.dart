import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:feedo_client_api/feedo_client_api.dart';

class BranchProvider {
  final Dio _client;

  BranchProvider(this._client);
  Future<List<Branch>> getAllBranch() async {
    try {
      final Response<ResponseBody> response = await _client.get('/branch');
      final fromList = response.data as List<dynamic>;
      return fromList.map((map) {
        return Branch.fromMap(map);
      }).toList();
    } on DioError catch (ex) {
      String errorMessage = json.decode(ex.response.toString())["errorMessage"];
      throw Exception(errorMessage);
    }
  }

  Future<Branch> getBranchById(int id) async {
    try {
      final Response<ResponseBody> response = await _client.get('/branch/$id');
      final fromMap = response.data as Map<String, dynamic>;
      return Branch.fromMap(fromMap);
    } on DioError catch (ex) {
      String errorMessage = json.decode(ex.response.toString())["errorMessage"];
      throw Exception(errorMessage);
    }
  }

  Future<void> saveBranch(Feedback feedback) async {
    await _client.post('/branch', data: feedback.toJson());
  }

  Future<void> updateBranch(int id, Feedback feedback) async {
    await _client.post('/branch/$id', data: feedback.toJson());
  }

  Future<void> deleteBranch(int id) async {
    try {
      await _client.post('/branch/$id');
    } on DioError catch (ex) {
      String errorMessage = json.decode(ex.response.toString())["errorMessage"];
      throw Exception(errorMessage);
    }
  }
}
