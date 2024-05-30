import 'package:flutter_project/features/book/data/models/book.dart';

abstract class BookshelfRepository {
  Future<void> addBook(VolumeInfoModel book, String userId);
  Future<void> updateBook(VolumeInfoModel book, String userId);
  Future<void> deleteBook(String bookId, String userId);
  Future<List<VolumeInfoModel>> getBooks(String userId);
}