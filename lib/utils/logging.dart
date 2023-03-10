import 'dart:convert';
import 'dart:developer';
import 'dart:io';

abstract class Logger {
  void printRequestLogHeader({
    required String url,
    required String type,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
  });
  void printRequestLogResponse({
    required int statusCode,
    required String body,
    required Map<String, String> headers,
  });
  void printRequestAuthHeader(Map<String, String> headers);
  void printExceptionError({
    required String description,
    required String message,
  });
}

class DebugLogger extends Logger {
  void _jsonStringLogPrint(String json, String name) {
    try {
      if (json.isEmpty) {
        log('[EMPTY]', name: name);
      } else {
        log(
          const JsonEncoder.withIndent('  ').convert(jsonDecode(json)),
          name: name,
        );
      }
    } catch (_) {
      log('[ERROR PARSING JSON]', name: name);
    }
  }

  void _jsonMapLogPrint(Map<String, dynamic> json, String name) {
    try {
      log(
        const JsonEncoder.withIndent('  ').convert(json),
        name: name,
      );
    } catch (_) {
      log('[ERROR PARSING JSON]', name: name);
    }
  }

  @override
  void printRequestLogHeader({
    required String url,
    required String type,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
  }) {
    log(
      '--------------------------------------------',
      name: 'HTTP REQUEST START',
    );

    log(url, name: type);

    if (params != null) {
      _jsonMapLogPrint(params, 'params');
    }
    if (body != null) {
      _jsonMapLogPrint(body, 'body');
    }
  }

  @override
  void printRequestLogResponse({
    required int statusCode,
    required String body,
    required Map<String, String> headers,
  }) {
    log(statusCode.toString(), name: 'status code');
    _jsonStringLogPrint(body, 'response');

    if (statusCode > 200) {
      _jsonMapLogPrint(headers, 'headers');
    }

    log(
      '----------------------------------------------',
      name: 'HTTP REQUEST END',
    );
  }

  @override
  void printRequestAuthHeader(Map<String, String> headers) {
    final authHeader = headers[HttpHeaders.authorizationHeader];

    log(authHeader?.split(' ')[0] ?? 'NONE', name: 'auth');
  }

  @override
  void printExceptionError({
    required String description,
    required String message,
  }) {
    log(
      '----------------------------------------------',
      name: 'EXCEPTION CAUGHT',
    );
    log(message, name: description);
    log(
      '------------------------------------------',
      name: 'EXCEPTION CAUGHT END',
    );
  }
}

class ReleaseLogger extends Logger {
  @override
  void printRequestLogHeader({
    required String url,
    required String type,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
  }) {}

  @override
  void printRequestLogResponse({
    required int statusCode,
    required String body,
    required Map<String, String> headers,
  }) {}

  @override
  void printRequestAuthHeader(Map<String, String> headers) {}

  @override
  void printExceptionError({
    required String description,
    required String message,
  }) {
    log(
      '----------------------------------------------',
      name: 'EXCEPTION CAUGHT',
    );
    log(message, name: description);
    log(
      '------------------------------------------',
      name: 'EXCEPTION CAUGHT END',
    );
  }
}
