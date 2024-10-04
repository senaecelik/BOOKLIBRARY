import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_project/app/index.dart';
import 'package:flutter_project/core/resources/data_state.dart';
import 'package:flutter_project/features/books/data/data_sources/remote/book_api_data_source/book_api_data_source.dart';
import 'package:flutter_project/features/books/data/model/book_model.dart';
import 'package:flutter_project/features/books/domain/repository/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final BookApiDataSource _bookApiService;

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
