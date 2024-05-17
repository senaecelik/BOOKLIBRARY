import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_project/app/index.dart';
import 'package:flutter_project/core/resources/data_state.dart';
import 'package:flutter_project/features/book/data/data_sources/remote/book_api_service.dart';
import 'package:flutter_project/features/book/data/models/book.dart';
import 'package:flutter_project/features/book/domain/repository/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final BookApiService _bookApiService;

  BookRepositoryImpl(this._bookApiService);
  @override
  Future<DataState<BookModel>> getBooks({required String query}) async {
    try {
      final httpResponse = await _bookApiService.getBook(
        apiKey: apiKey,
        query: query
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            requestOptions: httpResponse.response.requestOptions,
            type: DioExceptionType.badResponse,
            response: httpResponse.response,
            error: httpResponse.response.statusMessage));
      }
    } on DioException catch(e) {
      return DataFailed(e);
    }
  }


}
