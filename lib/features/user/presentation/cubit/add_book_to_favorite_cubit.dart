import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/features/auth/domain/entity/user_static_model.dart';
import 'package:flutter_project/features/books/data/model/book_detail_model.dart';
import 'package:flutter_project/features/books/domain/entities/book_detail_entity.dart';
import 'package:flutter_project/features/user/data/model/add_book_to_favorite_model.dart';
import 'package:flutter_project/features/user/domain/usecases/add_book_to_favorite_use_case.dart';

part 'add_book_to_favorite_state.dart';

class AddBookToFavoriteCubit extends Cubit<AddBookToFavoriteState> {
  final AddBookToFavoriteUseCase _addBookToFavoriteUseCase;
  AddBookToFavoriteCubit(this._addBookToFavoriteUseCase)
      : super(AddBookToFavoriteInitial());

  Future<void> addBookToFavorite(BookEntityDetail favBook) async {
  emit(AddBookToFavoriteLoading()); // Yükleniyor durumu
  try {
    // BookEntityDetail'den BookModelDetail'e dönüşüm yapmalısınız
    BookModelDetail bookModelDetail = BookModelDetail.fromEntity(favBook);
    AddBookToFavoriteModel addBookToFavoriteModel =
        AddBookToFavoriteModel.fromBookModelDetail(UserStaticModel.uid!, bookModelDetail);

    // Kitabı favorilere ekle
    _addBookToFavoriteUseCase.call(addBookToFavoriteModel).then((_) {
      // Başarılı durum tetikle
      emit(const AddBookToFavoriteDone(message: "Kitap favorilere eklendi!"));
    }).catchError((error) {
      // Hata durumunda
      emit(AddBookToFavoriteError(message: "Bir hata oluştu: ${error.toString()}"));
    });
  } on SocketException catch (e) {
    emit(AddBookToFavoriteError(message: "Ağ hatası: ${e.message}"));
  } catch (e) {
    emit(AddBookToFavoriteError(message: "Bir hata oluştu: ${e.toString()}"));
  }
}

}
