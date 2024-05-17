import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_project/core/resources/data_state.dart';
import 'package:flutter_project/features/book/domain/entities/book.dart';
import 'package:flutter_project/features/book/domain/usecases/get_best_seller_book.dart';
import 'package:flutter_project/features/book/domain/usecases/get_book.dart';
import 'package:flutter_project/injection_container.dart';

part 'remote_best_seller_book_state.dart';

class RemoteBestSellerBookCubit extends Cubit<RemoteBestSellerBookState> {
  final GetBestSellerBookUseCase _getBestSellerUseCase;
  final GetBookUseCase _getBookUseCase = GetBookUseCase(sl());

   List<BookEntity>? newbestseller = [];

  RemoteBestSellerBookCubit(
    this._getBestSellerUseCase,
  ) : super(const RemoteBestSellerBookLoading());

  void onGetBestSellerBook() async {
    newbestseller = [];
    final dataState = await _getBestSellerUseCase();
    if (dataState is DataSuccess && dataState.data != null) {
        if (dataState.data!.results != null) {
            for (var book in dataState.data!.results!) {
                var isbns = book.bookDetails!;
                for (var isbn in isbns) {
                    String isbnNumber13 = isbn.primaryIsbn13!;
                    final dataBookState = await _getBookUseCase(params: isbnNumber13);

                        newbestseller!.add(dataBookState.data!);
                    
                }
            }
            emit(RemoteBestSellerBookDone(newbestseller));
        }
    } else if (dataState is DataFailed) {
        emit(RemoteBestSellerBookError(dataState.error!));
    }
}

}
