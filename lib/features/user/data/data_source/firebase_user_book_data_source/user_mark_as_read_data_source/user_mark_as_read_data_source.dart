import 'package:flutter_project/features/user/domain/entity/add_book_entity.dart';

abstract class UserMarkAsReadDataSource {
  Future<void> markBookAsRead( AddBookEntity book);
  Future<void> addBookToFavoritesAndMarkAsRead(
      AddBookEntity book);
  Future<void> updateBookFavoriteStatus(
      String userId, String bookId, bool isFavorite);
  Future<void> removeFromReadBooks(String userId, String bookId);
  Future<void> removeFromFavorites(String userId, String bookId);
  Stream<List<AddBookEntity>> getUserReadBooks(String userId);
  Stream<List<AddBookEntity>> getOnlyFavoriteReadBooks(String userId);

  Future<void> addToWantToRead(AddBookEntity book); 
  Future<void> removeFromWantToRead(String userId, String bookId);
  Stream<List<AddBookEntity>> getUserWantToReadBooks(String userId);
}
