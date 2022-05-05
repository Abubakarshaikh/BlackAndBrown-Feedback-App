import 'package:dio/dio.dart';
import 'package:feedo_client_api/feedo_client_api.dart' show Question;
import 'dart:convert';

class QuestionProvider {
  final Dio _client;

  QuestionProvider(this._client);
  Future<List<Question>> getAllQuestion() async {
    try {
      final Response<ResponseBody> response = await _client.get('/question');
      final fromList = response.data as List<dynamic>;
      return fromList.map((map) {
        return Question.fromMap(map);
      }).toList();
    } on DioError catch (ex) {
      String errorMessage = json.decode(ex.response.toString())["errorMessage"];
      throw Exception(errorMessage);
    }
  }

  Future<Question> getQuestionById(int id) async {
    try {
      final Response<ResponseBody> response =
          await _client.get('/question/$id');
      final fromMap = response.data as Map<String, dynamic>;
      return Question.fromMap(fromMap);
    } on DioError catch (ex) {
      String errorMessage = json.decode(ex.response.toString())["errorMessage"];
      throw Exception(errorMessage);
    }
  }

  Future<void> saveQuestion(Question question) async {
    await _client.post('/question', data: question.toJson());
  }

  Future<void> updateQuestion(int id, Question question) async {
    await _client.post('/question/$id', data: question.toJson());
  }

  Future<void> deleteQuestion(int id) async {
    try {
      await _client.post('/question/$id');
    } on DioError catch (ex) {
      String errorMessage = json.decode(ex.response.toString())["errorMessage"];
      throw Exception(errorMessage);
    }
  }
}
