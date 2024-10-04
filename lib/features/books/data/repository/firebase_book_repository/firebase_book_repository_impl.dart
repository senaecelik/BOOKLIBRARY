import 'package:flutter_project/features/books/data/data_sources/remote/firebase_book_data_source/firebase_book_data_source.dart';
import 'package:flutter_project/features/books/data/model/book_model.dart';
import 'package:flutter_project/features/books/domain/entities/book_detail_entity.dart';
import 'package:flutter_project/features/books/domain/repository/firebase_book_repository.dart';

class FirebaseBookRepositoryImpl implements FirebaseBookRepository {
  final RemoteBookDataSource _dataSource;

  FirebaseBookRepositoryImpl(this._dataSource);

  @override
  Future<void> createBook(BookEntityDetail book) {
    return _dataSource.createBook(book);
  }

  // @override
  // Stream<List<BookModel>> readBooks(BookEntityDetail book) {
  //   return _dataSource.readBooks(book);
  // }

  



}
