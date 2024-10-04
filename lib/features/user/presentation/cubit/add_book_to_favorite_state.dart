part of 'add_book_to_favorite_cubit.dart';

abstract class AddBookToFavoriteState extends Equatable {
  const AddBookToFavoriteState();

  @override
  List<Object> get props => [];
}

final class AddBookToFavoriteInitial extends AddBookToFavoriteState {}

final class AddBookToFavoriteLoading extends AddBookToFavoriteState {}
final class AddBookToFavoriteError extends AddBookToFavoriteState {
final String message;

  const AddBookToFavoriteError({required this.message});
}
final class AddBookToFavoriteDone extends AddBookToFavoriteState {
  final String message;

  const AddBookToFavoriteDone({required this.message});
}


