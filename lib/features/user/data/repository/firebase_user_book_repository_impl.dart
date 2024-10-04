import 'package:flutter_project/features/books/data/model/book_detail_model.dart';
import 'package:flutter_project/features/books/domain/entities/book_detail_entity.dart';
import 'package:flutter_project/features/user/data/data_source/firebase_user_book_data_source/user_book_data_source.dart';
import 'package:flutter_project/features/user/domain/repository/firebase_user_book_repository.dart';

class FirebaseUserBookRepositoryImpl extends FirebaseUserBookRepository {
  final UserBookDataSource _userBookDataSource;

  FirebaseUserBookRepositoryImpl(this._userBookDataSource);

  @override
  Future<void> addBookToFavorite(String userId, BookEntityDetail book) {
    return _userBookDataSource.addBookToFavorites(userId, book);
  }

  @override
  Future<void> addToWantToRead(String userId, BookEntityDetail book) {
    return _userBookDataSource.addToWantToRead(userId, book);
  }

  @override
  Stream<List<BookModelDetail>> getUserFavoriteBooks(String userId) {
    return _userBookDataSource.getUserFavoriteBooks(userId);
  }

  @override
  Stream<List<BookModelDetail>> getUserReadBooks(String userId) {
    return _userBookDataSource.getUserReadBooks(userId);
  }

  @override
  Stream<List<BookModelDetail>> getUserWantToReadBooks(String userId) {
    return _userBookDataSource.getUserWantToReadBooks(userId);
  }

  @override
  Future<void> markBookAsRead(String userId, BookEntityDetail book) {
    return _userBookDataSource.markBookAsRead(userId, book);
  }

  @override
  Future<void> removeBookFromFavorites(String userId, String bookId) {
    return _userBookDataSource.removeBookFromFavorites(userId, bookId);
  }

  @override
  Future<void> removeFromReadBooks(String userId, String bookId) {
    return _userBookDataSource.removeFromReadBooks(userId, bookId);
  }

  @override
  Future<void> removeFromWantToRead(String userId, String bookId) {
    return _userBookDataSource.removeFromWantToRead(userId, bookId);
  }
}
