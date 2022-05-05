import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:feedo_client_api/feedo_client_api.dart' show Customer;

class CustomerProvider {
  final Dio _client;

  CustomerProvider(this._client);
  Future<List<Customer>> getAllCustomer() async {
    try {
      final Response<ResponseBody> response = await _client.get('/customer');
      final fromList = response.data as List<dynamic>;
      return fromList.map((map) {
        return Customer.fromMap(map);
      }).toList();
    } on DioError catch (ex) {
      String errorMessage = json.decode(ex.response.toString())["errorMessage"];
      throw Exception(errorMessage);
    }
  }

  Future<Customer> getCustomerById(int id) async {
    try {
      final Response<ResponseBody> response =
          await _client.get('/customer/$id');
      final fromMap = response.data as Map<String, dynamic>;
      return Customer.fromMap(fromMap);
    } on DioError catch (ex) {
      String errorMessage = json.decode(ex.response.toString())["errorMessage"];
      throw Exception(errorMessage);
    }
  }

  Future<void> saveCustomer(Customer customer) async {
    await _client.post('/customer', data: customer.toJson());
  }

  Future<void> updateCustomer(int id, Customer customer) async {
    await _client.post('/customer/$id', data: customer.toJson());
  }

  Future<void> deleteCustomer(int id) async {
    try {
      await _client.post('/customer/$id');
    } on DioError catch (ex) {
      String errorMessage = json.decode(ex.response.toString())["errorMessage"];
      throw Exception(errorMessage);
    }
  }
}
