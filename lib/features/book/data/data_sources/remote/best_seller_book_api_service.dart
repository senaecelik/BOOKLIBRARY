

import 'package:dio/dio.dart';
import 'package:flutter_project/app/index.dart';
import 'package:flutter_project/core/constant/api_constant.dart';
import 'package:flutter_project/features/book/data/models/best_seller_book.dart';
import 'package:retrofit/retrofit.dart';
part 'best_seller_book_api_service.g.dart';

@RestApi(baseUrl: nyBaseUrl)
abstract class BestSellerBookApiService {
  factory BestSellerBookApiService(Dio dio) = _BestSellerBookApiService;

 @GET('/lists.json?list-name=hardcover-fiction')
  Future<HttpResponse<BestSellerBookModel>> getBook({
    @Query("api-key") String? apiKey, // API anahtarı (gerekirse)
    // Diğer isteğe bağlı parametreler buraya eklenebilir
  });

}
