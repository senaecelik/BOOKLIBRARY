import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_project/features/user/domain/entity/add_book_entity.dart';
import 'package:flutter_project/features/user/domain/usecases/user_add_to_want_to_read_use_case.dart';
import 'package:flutter_project/features/user/domain/usecases/user_favorite_book_use_case.dart';
import 'package:flutter_project/features/user/domain/usecases/user_mark_as_read_use_case.dart';

part 'user_mark_as_read_state.dart';

class UserMarkAsReadCubit extends Cubit<UserMarkAsReadState> {
  final UserMarkAsReadUseCase _markAsReadUseCase;
  final UserFavoriteBookUseCase _favoriteBookUseCase;
  final UserAddToWantToReadUseCase _addToWantToReadUseCase;


  UserMarkAsReadCubit(this._markAsReadUseCase, this._favoriteBookUseCase, this._addToWantToReadUseCase) : super(UserMarkAsReadInitial());

  Future<void> markAsReadBook({required AddBookEntity book}) async {
    emit(UserMarkAsReadLoading());

    try {
      await _markAsReadUseCase.call(book);
      emit(UserMarkAsReadSuccess());
    } catch (e) {
      emit(UserMarkAsReadError(message: e.toString()));
    }
  }
  Future<void> addFavorite({required AddBookEntity book}) async {
    emit(UserMarkAsReadLoading());

    try {
      await _favoriteBookUseCase.call(book);
      emit(UserMarkAsReadSuccess());
    } catch (e) {
      emit(UserMarkAsReadError(message: e.toString()));
    }
  }
  
   Future<void> addWantToRead({required AddBookEntity book}) async {
    emit(UserMarkAsReadLoading());

    try {
      await _addToWantToReadUseCase.call(book);
      emit(UserMarkAsReadSuccess());
    } catch (e) {
      emit(UserMarkAsReadError(message: e.toString()));
    }
  }
}

