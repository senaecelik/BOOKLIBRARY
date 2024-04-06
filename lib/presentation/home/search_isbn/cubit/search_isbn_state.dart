part of 'search_isbn_cubit.dart';

abstract class SearchIsbnState extends Equatable {
  const SearchIsbnState();
  
  @override
  List<Object?> get props => [];
}

class SearchIsbnInitial extends SearchIsbnState {}
class SearchIsbnLoading extends SearchIsbnState {}


class SearchIsbnDisplay extends SearchIsbnState {
final BookModel book;

  const SearchIsbnDisplay(this.book);

  @override
  List<Object?> get props => [book];
}

class SearchIsbnError extends SearchIsbnState {
  final String message;

  const SearchIsbnError(this.message);

  @override
  List<Object?> get props => [message];
}
