// lib/services/api_service.dart
import 'package:dio/dio.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  ApiService._internal();

  final Dio _dio = Dio();
  String? _authToken;

  // Set base URL (configure this in main.dart or from config)
  final String baseUrl = 'http://localhost:5000/api';

  void setAuthToken(String token) {
    _authToken = token;
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearAuthToken() {
    _authToken = null;
    _dio.options.headers.remove('Authorization');
  }

  // ===== TASKS API =====

  // Get all tasks
  Future<List<Map<String, dynamic>>> getTasks({
    String? category,
    String? city,
    String? status,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final params = {
        'page': page,
        'limit': limit,
        if (category != null) 'category': category,
        if (city != null) 'city': city,
        if (status != null) 'status': status,
      };

      final response = await _dio.get(
        '$baseUrl/tasks',
        queryParameters: params,
      );

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data['tasks']);
      }
      throw Exception('Failed to fetch tasks');
    } on DioException catch (e) {
      throw Exception('Error: ${e.message}');
    }
  }

  // Get single task
  Future<Map<String, dynamic>> getTask(String taskId) async {
    try {
      final response = await _dio.get('$baseUrl/tasks/$taskId');
      if (response.statusCode == 200) {
        return response.data['task'];
      }
      throw Exception('Failed to fetch task');
    } on DioException catch (e) {
      throw Exception('Error: ${e.message}');
    }
  }

  // Create task
  Future<Map<String, dynamic>> createTask(
      Map<String, dynamic> taskData) async {
    try {
      final response = await _dio.post(
        '$baseUrl/tasks',
        data: taskData,
      );

      if (response.statusCode == 201) {
        return response.data['task'];
      }
      throw Exception('Failed to create task');
    } on DioException catch (e) {
      throw Exception('Error: ${e.message}');
    }
  }

  // Update task
  Future<Map<String, dynamic>> updateTask(
    String taskId,
    Map<String, dynamic> updateData,
  ) async {
    try {
      final response = await _dio.put(
        '$baseUrl/tasks/$taskId',
        data: updateData,
      );

      if (response.statusCode == 200) {
        return response.data['task'];
      }
      throw Exception('Failed to update task');
    } on DioException catch (e) {
      throw Exception('Error: ${e.message}');
    }
  }

  // Apply for task
  Future<Map<String, dynamic>> applyForTask(
    String taskId,
    Map<String, dynamic> applicationData,
  ) async {
    try {
      final response = await _dio.post(
        '$baseUrl/tasks/$taskId/apply',
        data: applicationData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['application'];
      }
      throw Exception('Failed to apply for task');
    } on DioException catch (e) {
      throw Exception('Error: ${e.message}');
    }
  }

  // Accept application
  Future<void> acceptApplication(
    String taskId,
    String applicantId,
  ) async {
    try {
      final response = await _dio.post(
        '$baseUrl/tasks/$taskId/accept-application',
        data: {'applicantId': applicantId},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to accept application');
      }
    } on DioException catch (e) {
      throw Exception('Error: ${e.message}');
    }
  }

  // ===== REVIEWS API =====

  // Create review
  Future<Map<String, dynamic>> createReview(
      Map<String, dynamic> reviewData) async {
    try {
      final response = await _dio.post(
        '$baseUrl/reviews',
        data: reviewData,
      );

      if (response.statusCode == 201) {
        return response.data['review'];
      }
      throw Exception('Failed to create review');
    } on DioException catch (e) {
      throw Exception('Error: ${e.message}');
    }
  }

  // Get user reviews
  Future<List<Map<String, dynamic>>> getUserReviews(
    String userId, {
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _dio.get(
        '$baseUrl/reviews/user/$userId',
        queryParameters: {'page': page, 'limit': limit},
      );

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data['reviews']);
      }
      throw Exception('Failed to fetch reviews');
    } on DioException catch (e) {
      throw Exception('Error: ${e.message}');
    }
  }

  // ===== USER API =====

  // Get user profile
  Future<Map<String, dynamic>> getUserProfile(String userId) async {
    try {
      final response = await _dio.get('$baseUrl/users/$userId');
      if (response.statusCode == 200) {
        return response.data['user'];
      }
      throw Exception('Failed to fetch user profile');
    } on DioException catch (e) {
      throw Exception('Error: ${e.message}');
    }
  }

  // Update user profile
  Future<Map<String, dynamic>> updateUserProfile(
    String userId,
    Map<String, dynamic> profileData,
  ) async {
    try {
      final response = await _dio.put(
        '$baseUrl/users/$userId',
        data: profileData,
      );

      if (response.statusCode == 200) {
        return response.data['user'];
      }
      throw Exception('Failed to update profile');
    } on DioException catch (e) {
      throw Exception('Error: ${e.message}');
    }
  }

  // Upload certification
  Future<Map<String, dynamic>> uploadCertification(
    String userId,
    FormData formData,
  ) async {
    try {
      final response = await _dio.post(
        '$baseUrl/users/$userId/certifications',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['certification'];
      }
      throw Exception('Failed to upload certification');
    } on DioException catch (e) {
      throw Exception('Error: ${e.message}');
    }
  }

  // ===== CATEGORIES API =====

  // Get all categories
  Future<List<Map<String, dynamic>>> getCategories() async {
    try {
      final response = await _dio.get('$baseUrl/categories');
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data['categories']);
      }
      throw Exception('Failed to fetch categories');
    } on DioException catch (e) {
      throw Exception('Error: ${e.message}');
    }
  }
}
