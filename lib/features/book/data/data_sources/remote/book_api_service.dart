import 'package:dio/dio.dart';
import 'package:flutter_project/app/index.dart';
import 'package:flutter_project/core/constant/api_constant.dart';
import 'package:flutter_project/features/book/data/models/book.dart';
import 'package:retrofit/retrofit.dart';
part 'book_api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class BookApiService {
  factory BookApiService(Dio dio) = _BookApiService;

 @GET('/volumes')
  Future<HttpResponse<BookModel>> getBook({
    @Query("q") String? query, // Arama sorgusu
    @Query("key") String? apiKey, // API anahtarı (gerekirse)
    // Diğer isteğe bağlı parametreler buraya eklenebilir
  });

}
