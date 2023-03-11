import 'dart:convert';

import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/models/book.dart';
import 'package:flutter_test_app/services/network_service/network_service.dart';
import 'package:flutter_test_app/utils/errors.dart';
import 'package:flutter_test_app/utils/iterable_utils.dart';
import 'package:flutter_test_app/utils/status_codes.dart';
import 'package:flutter_test_app/utils/types.dart';

final _volumesEndpoint = '${Environment.googleBooksApiBaseUrl}'
    '${Environment.googleBooksApiVolumesEndpoint}';

class BookRepository {
  static Future<ApiResponse<List<Book>>> searchBooks(String searchTerm) async {
    try {
      final response = await networkService.get(
        _volumesEndpoint,
        params: {'q': searchTerm},
      );

      if (response.statusCode == okStatusCode) {
        final data = jsonDecode(response.body);
        final items = data['items'] as Iterable;

        final books = items.mapList((item) => Book.fromJson(item));

        return ApiResponse(success: true, data: books);
      }

      if (response.statusCode == timeoutStatusCode) {
        return const ApiResponse(
          success: false,
          errorCode: Errors.httpRequestTimeout,
        );
      }

      return const ApiResponse(success: false);
    } catch (e) {
      return ApiResponse(
        success: false,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<ApiResponse<Book>> fetchBook(Id id) async {
    try {
      final response = await networkService.get('$_volumesEndpoint/$id');

      if (response.statusCode == okStatusCode) {
        return ApiResponse(success: true, data: Book.fromJson(response.body));
      }

      if (response.statusCode == timeoutStatusCode) {
        return const ApiResponse(
          success: false,
          errorCode: Errors.httpRequestTimeout,
        );
      }

      return const ApiResponse(success: false);
    } catch (e) {
      return ApiResponse(
        success: false,
        errorMessage: e.toString(),
      );
    }
  }
}
