


import 'package:flutter_project/features/books/data/model/book_detail_model.dart';
import 'package:flutter_project/features/books/domain/entities/book_detail_entity.dart';

abstract class FirebaseUserBookRepository{

Future<void> addBookToFavorite(String userId, BookEntityDetail book);
  Future<void> markBookAsRead(String userId, BookEntityDetail book);
  Future<void> addToWantToRead(String userId, BookEntityDetail book);
  
  Future<void> removeBookFromFavorites(String userId, String bookId);
  Future<void> removeFromWantToRead(String userId, String bookId);
  Future<void> removeFromReadBooks(String userId, String bookId);
  
  Stream<List<BookModelDetail>> getUserReadBooks(String userId);
  Stream<List<BookModelDetail>> getUserFavoriteBooks(String userId);
  Stream<List<BookModelDetail>> getUserWantToReadBooks(String userId);

}