import 'package:flutter_project/features/books/data/model/book_detail_model.dart';
import 'package:flutter_project/features/books/domain/entities/book_base_entity.dart';
import 'package:flutter_project/features/books/domain/entities/book_detail_entity.dart';

abstract class UserBookDataSource {
  Future<void> addBookToFavorites(String userId, BookBaseEntity book);
  Future<void> markBookAsRead(String userId, BookBaseEntity book);
  Future<void> addToWantToRead(String userId, BookBaseEntity book);
  
  Future<void> removeBookFromFavorites(String userId, String bookId);
  Future<void> removeFromWantToRead(String userId, String bookId);
  Future<void> removeFromReadBooks(String userId, String bookId);
  
  Stream<List<BookModelDetail>> getUserReadBooks(String userId);
  Stream<List<BookModelDetail>> getUserFavoriteBooks(String userId);
  Stream<List<BookModelDetail>> getUserWantToReadBooks(String userId);
}
