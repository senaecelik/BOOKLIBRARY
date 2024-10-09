import 'package:flutter_project/features/books/domain/entities/book_detail_entity.dart';

abstract class RemoteBookDataSource {
  Future<void> createBook(BookEntityDetail book);
  // Stream<List<BookModel>> readBooks(BookEntityDetail book);
}
