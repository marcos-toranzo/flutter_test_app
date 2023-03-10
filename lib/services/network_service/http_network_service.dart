import 'dart:convert';
import 'dart:io';

import 'package:flutter_test_app/utils/storage.dart';
import 'package:http/http.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/services/network_service/network_service.dart';

const timeoutDuration = Duration(seconds: 5);

Response timeoutResponse() => Response('timeout', 408);

/// Network service that uses http Flutter package.
///
/// See https://pub.dev/packages/http for information about the package.
class HttpNetworkService implements NetworkService {
  final Client _httpClient = Client();

  final _encoding = Encoding.getByName('utf-8');

  /// Header for every api call
  Future<Map<String, String>> _getHeaders() async {
    final headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final accessToken = await loadAccessToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
    }

    logger.printRequestAuthHeader(headers);

    return headers;
  }

  Future<NetworkResponse> _requestWithBody(
    Future<Response> Function(
      Uri url, {
      Map<String, String>? headers,
      Object? body,
      Encoding? encoding,
    })
        method,
    String url,
    String methodName, {
    Map<String, dynamic> body = const <String, dynamic>{},
  }) async {
    logger.printRequestLogHeader(
      url: url,
      type: methodName,
      body: body,
    );

    final response = await method(
      Uri.parse(url),
      headers: await _getHeaders(),
      body: json.encode(body),
      encoding: _encoding,
    ).timeout(timeoutDuration, onTimeout: timeoutResponse);

    logger.printRequestLogResponse(
      statusCode: response.statusCode,
      body: response.body,
      headers: response.headers,
    );

    return NetworkResponse(
      statusCode: response.statusCode,
      body: response.body,
    );
  }

  @override
  Future<NetworkResponse> get(
    String url, {
    Map<String, dynamic>? params,
  }) async {
    logger.printRequestLogHeader(
      url: url,
      type: 'GET',
      params: params,
    );

    var urlWithParams = url;

    if (params != null && params.isNotEmpty) {
      final queryParams = Uri(queryParameters: params).query;
      urlWithParams += '?$queryParams';
    }

    final response = await _httpClient
        .get(
          Uri.parse(urlWithParams),
          headers: await _getHeaders(),
        )
        .timeout(timeoutDuration, onTimeout: timeoutResponse);

    logger.printRequestLogResponse(
      statusCode: response.statusCode,
      body: response.body,
      headers: response.headers,
    );

    return NetworkResponse(
      statusCode: response.statusCode,
      body: response.body,
    );
  }

  @override
  Future<NetworkResponse> post(
    String url, {
    Map<String, dynamic> body = const <String, dynamic>{},
  }) =>
      _requestWithBody(_httpClient.post, url, 'POST', body: body);

  @override
  Future<NetworkResponse> put(
    String url, {
    Map<String, dynamic> body = const <String, dynamic>{},
  }) =>
      _requestWithBody(_httpClient.put, url, 'PUT', body: body);

  @override
  Future<NetworkResponse> patch(
    String url, {
    Map<String, dynamic> body = const <String, dynamic>{},
  }) =>
      _requestWithBody(_httpClient.patch, url, 'PATCH', body: body);

  @override
  Future<NetworkResponse> delete(String url) =>
      _requestWithBody(_httpClient.delete, url, 'DELETE');
}
