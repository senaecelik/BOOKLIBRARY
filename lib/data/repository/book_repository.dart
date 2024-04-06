import 'package:dio/dio.dart';
import 'package:flutter_project/app/api_constant.dart';
import 'package:flutter_project/core/client/network_client.dart';
import 'package:flutter_project/data/responses/book_response.dart';
import 'package:dartz/dartz.dart';

class BookRepository {
  BookRepository(NetworkClient networkManager)
      : _networkManager = networkManager;

  final NetworkClient _networkManager;

  Future<Either<Exception, BookModel>> getBookInfo(
      {required BookRequest bookRequest}) async {
    try {
      final response = await _networkManager.get<BookModel>(
          "https://api.orhanaydogdu.com.tr/isbn/", "isbn/",
          options: Options(
            contentType: "application/json",
            headers: {
              "Content-Type": "application/json",
              // "authorization": "apikey ${ApiConstant.apiKey}"
            },
          ),
          queryParameters: bookRequest.toJson());
      return Right(response.data!);
    } catch (e) {
      return Left(Exception("Error: $e"));
    }
  }
}
