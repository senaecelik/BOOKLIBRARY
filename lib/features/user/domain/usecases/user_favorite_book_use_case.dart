





import 'package:flutter_project/core/usecase/usecase.dart';
import 'package:flutter_project/features/user/domain/entity/add_book_entity.dart';
import 'package:flutter_project/features/user/domain/repository/firebase_user_mark_as_read_repository.dart';

class UserFavoriteBookUseCase implements UseCaseFuture<void, AddBookEntity >{
  final FirebaseUserMarkAsReadRepository repository;

  UserFavoriteBookUseCase(this.repository);
  @override
  Future<void> call( AddBookEntity params) async{
   await repository.addBookToFavoritesAndMarkAsRead(params);
  }


}