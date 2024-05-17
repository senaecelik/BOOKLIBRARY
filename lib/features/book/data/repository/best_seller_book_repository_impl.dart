import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_project/app/index.dart';
import 'package:flutter_project/core/resources/data_state.dart';
import 'package:flutter_project/features/book/data/data_sources/remote/best_seller_book_api_service.dart';
import 'package:flutter_project/features/book/data/models/best_seller_book.dart';
import 'package:flutter_project/features/book/domain/repository/best_seller_book_repository.dart';

class BestSellerBookRepositoryImpl implements BestSellerBookRepository {
  final BestSellerBookApiService _bookApiService;

  BestSellerBookRepositoryImpl(this._bookApiService);
  @override
  Future<DataState<BestSellerBookModel>> getBestSellerBooks() async {
    try {
      final httpResponse = await _bookApiService.getBook(
        apiKey: nyApiKey,
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