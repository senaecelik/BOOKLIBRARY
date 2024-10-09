part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

 class HomeInitial extends HomeState {}
 class HomeLoading extends HomeState {}
 class HomeDone extends HomeState {
  final List<AddBookEntity> bookList;

  const HomeDone({required this.bookList});
}
 class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});
 }

