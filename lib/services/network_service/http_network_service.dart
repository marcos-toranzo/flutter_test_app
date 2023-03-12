import 'dart:convert';
import 'dart:io';

import 'package:flutter_test_app/utils/status_codes.dart';
import 'package:http/http.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/services/network_service/network_service.dart';

const _timeoutDuration = Duration(seconds: 5);

Response _timeoutResponse() => Response('timeout', timeoutStatusCode);

typedef HttpMethod = Future<Response> Function(
  Uri url, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
});

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

    logger.printRequestAuthHeader(headers);

    return headers;
  }

  Future<NetworkResponse> _request(
    HttpMethod method,
    String url,
    String methodName, {
    Map<String, dynamic> params = const {},
    Map<String, dynamic>? body,
  }) async {
    logger.printRequestLogHeader(
      url: url,
      type: methodName,
      body: body,
    );

    final paramsWithKey = Map<String, dynamic>.from({
      ...params,
      'key': Environment.googleBooksApiKey,
    });

    var urlWithParams = '$url?${Uri(queryParameters: paramsWithKey).query}';

    final response = await method(
      Uri.parse(urlWithParams),
      headers: await _getHeaders(),
      body: body != null ? json.encode(body) : null,
      encoding: _encoding,
    ).timeout(_timeoutDuration, onTimeout: _timeoutResponse);

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
    Map<String, dynamic> params = const {},
  }) =>
      _request(
        (url, {body, encoding, headers}) =>
            _httpClient.get(url, headers: headers),
        url,
        'POST',
        params: params,
      );

  @override
  Future<NetworkResponse> post(
    String url, {
    Map<String, dynamic> body = const <String, dynamic>{},
  }) =>
      _request(_httpClient.post, url, 'POST', body: body);

  @override
  Future<NetworkResponse> put(
    String url, {
    Map<String, dynamic> body = const <String, dynamic>{},
  }) =>
      _request(_httpClient.put, url, 'PUT', body: body);

  @override
  Future<NetworkResponse> patch(
    String url, {
    Map<String, dynamic> body = const <String, dynamic>{},
  }) =>
      _request(_httpClient.patch, url, 'PATCH', body: body);

  @override
  Future<NetworkResponse> delete(String url) =>
      _request(_httpClient.delete, url, 'DELETE');
}
