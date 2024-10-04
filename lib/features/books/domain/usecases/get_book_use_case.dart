


import 'package:flutter_project/core/resources/data_state.dart';
import 'package:flutter_project/core/usecase/usecase.dart';
import 'package:flutter_project/features/books/data/model/book_model.dart';
import 'package:flutter_project/features/books/data/model/books_model.dart';
import 'package:flutter_project/features/books/domain/repository/book_repository.dart';

class GetBookUseCase implements UseCaseFuture<DataState<BookModel>, String>{
  
  final BookRepository _bookRepository;

  GetBookUseCase(this._bookRepository);
  
  @override
  Future<DataState<BookModel>> call(query) {
    return _bookRepository.getBooks(query: query);
  }

}