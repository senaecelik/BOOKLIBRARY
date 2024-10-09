import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_project/features/auth/domain/entity/user_static_model.dart';
import 'package:flutter_project/features/user/domain/entity/add_book_entity.dart';
import 'package:flutter_project/features/user/domain/usecases/user_get_only_favorite_read_book.dart';
import 'package:flutter_project/features/user/domain/usecases/user_get_read_books_use_case.dart';
import 'package:flutter_project/features/user/domain/usecases/user_get_want_to_read_use_case.dart';

part 'home_state.dart';

enum BookCategory { read, favBook, unread, wantRead }

class HomeCubit extends Cubit<HomeState> {
  final UserGetReadBooksUseCase _booksUseCase;
  final UserGetOnlyFavoriteReadBook _favoriteReadBook;
  final UserGetWantToReadUseCase _getWantToReadUseCase;

  BookCategory _selectedCategory = BookCategory.read;

  HomeCubit(
      this._booksUseCase, this._favoriteReadBook, this._getWantToReadUseCase)
      : super(HomeInitial());

  // Getter for selectedCategory
  BookCategory get selectedCategory => _selectedCategory;

  void selectCategory(BookCategory category) {
    emit(HomeInitial());
    _selectedCategory = category;
    emit(HomeLoading());

    _fetchBooksBasedOnCategory();
  }

  void _fetchBooksBasedOnCategory() {
    switch (_selectedCategory) {
      case BookCategory.read:
        getUserReadBooks();
        break;
      case BookCategory.favBook:
        getUserFavoriteBooks();
        break;
      case BookCategory.unread:
        getUserReadBooks();
        break;
      case BookCategory.wantRead:
        break;
    }
  }

  void getUserReadBooks() {
    emit(HomeLoading());

    try {
      // Stream'i dinle ve durumu güncelle
      _booksUseCase.call(params: UserStaticModel.uid!).listen(
        (readBookList) {
          emit(HomeDone(bookList: readBookList));
        },
        onError: (error) {
          emit(HomeError(message: error.toString()));
        },
      );
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  void getUserFavoriteBooks() {
    emit(HomeLoading());

    try {
      // Stream'i dinle ve durumu güncelle
      _favoriteReadBook.call(params: UserStaticModel.uid!).listen(
        (readBookList) {
          emit(HomeDone(bookList: readBookList));
        },
        onError: (error) {
          emit(HomeError(message: error.toString()));
        },
      );
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  void getWantToRead() {
    emit(HomeLoading());

    try {
      // Stream'i dinle ve durumu güncelle
      _getWantToReadUseCase.call(params: UserStaticModel.uid!).listen(
        (readBookList) {
          emit(HomeDone(bookList: readBookList));
        },
        onError: (error) {
          emit(HomeError(message: error.toString()));
        },
      );
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
