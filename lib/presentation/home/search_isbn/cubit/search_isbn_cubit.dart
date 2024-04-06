import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/data/repository/book_repository.dart';
import 'package:flutter_project/data/responses/book_response.dart';


part 'search_isbn_state.dart';

class SearchIsbnCubit extends Cubit<SearchIsbnState> {

  SearchIsbnCubit({required BookRepository bookRepository}) : _bookRepository = bookRepository,  super(SearchIsbnInitial());


  late final BookRepository _bookRepository;

  

  Future<void> query({required String isbn}) async {
    emit(SearchIsbnLoading());

    try {
      final response = await _bookRepository.getBookInfo(bookRequest: BookRequest(isbn: isbn));
      response.fold(
        (error) => emit(const SearchIsbnError('Failed to fetch book information')),
        (book) =>  emit(SearchIsbnDisplay(book)),
      );
    } catch (e) {
      emit(const SearchIsbnError('Failed to fetch book information'));
    }
  }
}
