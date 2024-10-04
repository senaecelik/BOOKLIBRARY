




import 'package:flutter_project/features/books/data/model/book_model.dart';
import 'package:flutter_project/features/books/data/model/books_model.dart';
import 'package:flutter_project/features/books/domain/entities/book_detail_entity.dart';
import 'package:flutter_project/features/books/domain/entities/book_entity.dart';

abstract class FirebaseBookRepository{


  Future<void> createBook(BookEntityDetail book);
  // Stream<List<BookModel>> readBooks(BookEntityDetail book);

}