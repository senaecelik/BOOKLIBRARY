





import 'package:flutter_project/core/usecase/usecase.dart';
import 'package:flutter_project/features/user/domain/entity/add_book_entity.dart';
import 'package:flutter_project/features/user/domain/repository/firebase_user_mark_as_read_repository.dart';

class UserGetOnlyFavoriteReadBook implements UseCaseStream<void, String >{
  final FirebaseUserMarkAsReadRepository repository;

  UserGetOnlyFavoriteReadBook(this.repository);
  
  @override
  Stream<List<AddBookEntity>> call({required String params}) {
   return repository.getOnlyFavoriteReadBooks(params);
  }
  
  
}