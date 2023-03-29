import 'dart:convert';

import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/models/book.dart';
import 'package:flutter_test_app/services/network_service/network_service.dart';
import 'package:flutter_test_app/utils/errors.dart';
import 'package:flutter_test_app/utils/status_code.dart';
import 'package:flutter_test_app/utils/types.dart';
import 'package:flutter_test_app/utils/iterable_utils.dart';

final _volumesEndpoint = '${Environment.googleBooksApiBaseUrl}/volumes';

abstract class BookRepository {
  static Future<ApiResponse<List<Book>>> searchBooks({
    required String searchTerm,
    int? maxResults,
  }) async {
    try {
      final params = {
        'q': searchTerm,
        'maxResults': maxResults?.toString() ?? '40',
      };

      final response = await networkService.get(
        _volumesEndpoint,
        params: params,
      );

      if (response.statusCode == StatusCode.ok.code) {
        final data = jsonDecode(response.body);
        final items = (data['items'] as List).cast<Map<String, dynamic>>();

        return SuccessApiResponse(data: items.mapList(Book.fromMap));
      }

      if (response.statusCode == StatusCode.timeout.code) {
        return const ErrorApiResponse(errorCode: Error.httpRequestTimeout);
      }

      return ErrorApiResponse(
        errorCode: Error.unknown,
        errorMessage: response.body,
      );
    } catch (e) {
      return ErrorApiResponse(errorMessage: e.toString());
    }
  }

  static Future<ApiResponse<Book>> fetchBook(Id id) async {
    try {
      final response = await networkService.get('$_volumesEndpoint/$id');

      if (response.statusCode == StatusCode.ok.code) {
        return SuccessApiResponse(data: Book.fromJson(response.body));
      }

      if (response.statusCode == StatusCode.timeout.code) {
        return const ErrorApiResponse(errorCode: Error.httpRequestTimeout);
      }

      return ErrorApiResponse(
        errorCode: Error.unknown,
        errorMessage: response.body,
      );
    } catch (e) {
      return ErrorApiResponse(errorMessage: e.toString());
    }
  }
}
