import 'package:dio/dio.dart';
import 'package:feedo_client_api/feedo_client_api.dart' show Feedback;
import 'dart:convert';

class FeedbackProvider {
  final Dio _client;

  FeedbackProvider(this._client);
  Future<List<Feedback>> getAllFeedback() async {
    try {
      final Response<ResponseBody> response = await _client.get('/feedback');
      final fromList = response.data as List<dynamic>;
      return fromList.map((map) {
        return Feedback.fromMap(map);
      }).toList();
    } on DioError catch (ex) {
      String errorMessage = json.decode(ex.response.toString())["errorMessage"];
      throw Exception(errorMessage);
    }
  }

  Future<Feedback> getFeedbackById(int id) async {
    try {
      final Response<ResponseBody> response =
          await _client.get('/feedback/$id');
      final fromMap = response.data as Map<String, dynamic>;
      return Feedback.fromMap(fromMap);
    } on DioError catch (ex) {
      String errorMessage = json.decode(ex.response.toString())["errorMessage"];
      throw Exception(errorMessage);
    }
  }

  Future<void> saveFeedback(Feedback feedback) async {
    await _client.post('/feedback', data: feedback.toJson());
  }

  Future<void> updateFeedback(int id, Feedback feedback) async {
    await _client.post('/feedback/$id', data: feedback.toJson());
  }

  Future<void> deleteFeedback(int id) async {
    try {
      await _client.post('/feedback/$id');
    } on DioError catch (ex) {
      String errorMessage = json.decode(ex.response.toString())["errorMessage"];
      throw Exception(errorMessage);
    }
  }
}
