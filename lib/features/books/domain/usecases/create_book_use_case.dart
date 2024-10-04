

import 'package:flutter_project/core/usecase/usecase.dart';
import 'package:flutter_project/features/books/domain/entities/book_detail_entity.dart';
import 'package:flutter_project/features/books/domain/repository/firebase_book_repository.dart';


class CreateBookUseCase implements UseCaseFuture<void, BookEntityDetail > {
  final FirebaseBookRepository repository;

  CreateBookUseCase( this.repository);

  @override
  Future<void> call(BookEntityDetail bookEntity) {
    return repository.createBook(bookEntity);
  }
}