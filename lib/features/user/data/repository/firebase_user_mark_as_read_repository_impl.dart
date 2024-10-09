import 'package:flutter_project/features/user/data/data_source/firebase_user_book_data_source/user_mark_as_read_data_source/user_mark_as_read_data_source.dart';
import 'package:flutter_project/features/user/domain/entity/add_book_entity.dart';
import 'package:flutter_project/features/user/domain/repository/firebase_user_mark_as_read_repository.dart';

class FirebaseUserMarkAsReadRepositoryImpl
    extends FirebaseUserMarkAsReadRepository {
  final UserMarkAsReadDataSource _dataSource;

  FirebaseUserMarkAsReadRepositoryImpl(this._dataSource);

  @override
  Future<void> addBookToFavoritesAndMarkAsRead(
       AddBookEntity book) async {
    await _dataSource.addBookToFavoritesAndMarkAsRead( book);
  }

  @override
  Future<void> updateBookFavoriteStatus(
      String userId, String bookId, bool isFavorite) async {
    await _dataSource.updateBookFavoriteStatus(userId, bookId, isFavorite);
  }

  @override
  Stream<List<AddBookEntity>> getOnlyFavoriteReadBooks(String userId) {
    return _dataSource.getOnlyFavoriteReadBooks(userId);
  }

  @override
  Stream<List<AddBookEntity>> getUserReadBooks(String userId) {
    return _dataSource.getUserReadBooks(userId);
  }

  @override
  Future<void> markBookAsRead(AddBookEntity book) async {
    await _dataSource.markBookAsRead( book);
  }

  @override
  Future<void> removeFromFavorites(String userId, String bookId) async {
    await _dataSource.removeFromFavorites(userId, bookId);
  }

  @override
  Future<void> removeFromReadBooks(String userId, String bookId) async {
    await _dataSource.removeFromReadBooks(userId, bookId);
  }
  
  @override
  Future<void> addToWantToRead(AddBookEntity book) async{
   await _dataSource.addToWantToRead(book);
  }
  
  @override
  Stream<List<AddBookEntity>> getUserWantToReadBooks(String userId) {
    return _dataSource.getUserWantToReadBooks(userId);
  }
  
  @override
  Future<void> removeFromWantToRead(String userId, String bookId)async {
    _dataSource.removeFromWantToRead(userId, bookId);
  }
}
