




import 'package:flutter_project/core/resources/data_state.dart';
import 'package:flutter_project/features/book/data/models/best_seller_book.dart';

abstract class BestSellerBookRepository{

  Future<DataState<BestSellerBookModel>> getBestSellerBooks();
}