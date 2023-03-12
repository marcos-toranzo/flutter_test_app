import 'package:flutter_test_app/utils/errors.dart';

abstract class NetworkService {
  Future<NetworkResponse> get(
    String url, {
    Map<String, dynamic> params = const {},
  });

  Future<NetworkResponse> post(
    String url, {
    Map<String, dynamic> body = const <String, dynamic>{},
  });

  Future<NetworkResponse> put(
    String url, {
    Map<String, dynamic> body = const <String, dynamic>{},
  });

  Future<NetworkResponse> patch(
    String url, {
    Map<String, dynamic> body = const <String, dynamic>{},
  });

  Future<NetworkResponse> delete(String url);
}

/// Generic class for network responses
class NetworkResponse {
  final int statusCode;
  final String body;

  const NetworkResponse({
    required this.statusCode,
    required this.body,
  });
}

/// Model to struct api responses
class ApiResponse<T> {
  final T? data;
  final bool success;
  final String? errorMessage;
  final Errors? errorCode;

  const ApiResponse({
    this.data,
    required this.success,
    this.errorMessage,
    this.errorCode,
  });
}
