import 'package:flutter_project/core/usecase/usecase.dart';
import 'package:flutter_project/features/user/data/model/add_book_to_favorite_model.dart';
import 'package:flutter_project/features/user/domain/repository/firebase_user_book_repository.dart';

class AddBookToFavoriteUseCase
    implements UseCaseFuture<void, AddBookToFavoriteModel> {
  final FirebaseUserBookRepository repository;

  AddBookToFavoriteUseCase(this.repository);

  @override
  Future<void> call(AddBookToFavoriteModel params) {
    return repository.addBookToFavorite(params.userId, params.bookEntity);
  }
}
