import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/core/resources/data_state.dart';
import 'package:flutter_project/features/book/domain/entities/book.dart';
import 'package:flutter_project/features/book/domain/usecases/get_book.dart';

part 'remote_book_state.dart';

class RemoteBookCubit extends Cubit<RemoteBookState> {
  final GetBookUseCase _getBookUseCase;

  RemoteBookCubit(this._getBookUseCase) : super(const RemoteBookInitial());

  void onGetBook({required String query}) async {
    emit(const RemoteBookLoading());
    final dataState = await _getBookUseCase(params: query);
    if (dataState is DataSuccess && dataState.data != null) {
      emit(RemoteBookDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteBookError(dataState.error!));
    }
  }
}
