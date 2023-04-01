import 'package:flutter_test_app/services/network_service/network_service.dart';

import 'data.dart';

class MockNetworkService extends NetworkService {
  @override
  Future<NetworkResponse> delete(String url) {
    throw UnimplementedError();
  }

  @override
  Future<NetworkResponse> get(
    String url, {
    Map<String, dynamic> params = const {},
  }) async {
    late final String body;

    final searchTerm = params['q'];

    body =
        searchTerm != null ? bookCategoriesResults[searchTerm]! : fictionBook;

    return NetworkResponse(statusCode: 200, body: body);
  }

  @override
  Future<NetworkResponse> patch(String url,
      {Map<String, dynamic> body = const <String, dynamic>{}}) {
    throw UnimplementedError();
  }

  @override
  Future<NetworkResponse> post(String url,
      {Map<String, dynamic> body = const <String, dynamic>{}}) {
    throw UnimplementedError();
  }

  @override
  Future<NetworkResponse> put(String url,
      {Map<String, dynamic> body = const <String, dynamic>{}}) {
    throw UnimplementedError();
  }
}
