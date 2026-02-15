import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(ref.read(apiClientProvider)));

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(ApiEndpoints.login, data: {
        'username': email, // Using email as username for now as per Django logic
        'password': password,
      });
      return response.data;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Login failed';
    }
  }

  Future<Map<String, dynamic>> register(String email, String password, String name) async {
    try {
      final response = await _dio.post(ApiEndpoints.register, data: {
        'username': email,
        'email': email,
        'password': password,
        'first_name': name,
      });
      return response.data;
    } on DioException catch (e) {
       throw e.response?.data['message'] ?? 'Registration failed';
    }
  }
}
