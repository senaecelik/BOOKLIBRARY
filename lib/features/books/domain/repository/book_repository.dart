




import 'package:flutter_project/core/resources/data_state.dart';
import 'package:flutter_project/features/books/data/model/book_model.dart';
import 'package:flutter_project/features/books/data/model/books_model.dart';

abstract class BookRepository{

  Future<DataState<BookModel>> getBooks({required String query});


}