import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/core/resources/data_state.dart';
import 'package:flutter_project/features/books/domain/entities/book_detail_entity.dart';
import 'package:flutter_project/features/books/domain/entities/book_entity.dart';
import 'package:flutter_project/features/books/domain/usecases/create_book_use_case.dart';
import 'package:flutter_project/features/books/domain/usecases/get_book_use_case.dart';

part 'remote_book_state.dart';

class RemoteBookCubit extends Cubit<RemoteBookState> {
  final GetBookUseCase _getBookUseCase;
  final CreateBookUseCase _createBookUseCase;

  RemoteBookCubit(this._getBookUseCase, this._createBookUseCase) : super(const RemoteBookInitial());

  void onGetBook({required String query}) async {
    emit(const RemoteBookLoading());
    final dataState = await _getBookUseCase.call("=isbn:$query");
    if (dataState is DataSuccess && dataState.data != null) {
       await _createBookUseCase.call(dataState.data!.items!.first.bookModelDetail!);
      emit(RemoteBookDone(dataState.data!.items!.first.bookModelDetail!));
    }

    if (dataState is DataFailed) {
      emit(RemoteBookError(dataState.error!));
    }
  }
}
