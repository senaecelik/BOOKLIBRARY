




import 'package:flutter_project/core/resources/data_state.dart';
import 'package:flutter_project/features/book/domain/entities/book.dart';

abstract class BookRepository{

  Future<DataState<BookEntity>> getBooks({required String query});


}