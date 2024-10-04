import 'package:dio/dio.dart';
import 'package:flutter_project/app/index.dart';
import 'package:flutter_project/core/constant/api_constant.dart';
import 'package:flutter_project/features/books/data/model/book_model.dart';
import 'package:flutter_project/features/books/data/model/books_model.dart';
import 'package:retrofit/retrofit.dart';
part 'book_api_data_source.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class BookApiDataSource{
  factory BookApiDataSource(Dio dio) = _BookApiDataSource;

 @GET('/volumes')
  Future<HttpResponse<BookModel>> getBook({
    @Query("q") String? query, // Arama sorgusu
    @Query("key") String? apiKey, // API anahtarı (gerekirse)
    // Diğer isteğe bağlı parametreler buraya eklenebilir
  });

}
