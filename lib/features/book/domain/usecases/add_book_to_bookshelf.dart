// import 'package:equatable/equatable.dart';
// import 'package:flutter_project/core/usecase/usecase.dart';
// import 'package:flutter_project/features/book/data/models/book.dart';
// import 'package:flutter_project/features/book/domain/repository/book_shelf_repository.dart';

// class AddBookUseCase implements UseCase<void, AddBookParams> {
//   final BookshelfRepository _repository;

//   AddBookUseCase(this._repository);

//   @override
//   Future<void> call({required AddBookParams params}) {
//     return _repository.addBook(params.book, params.userId);
//   }
// }

// class AddBookParams extends Equatable {
//   final VolumeInfoModel book;
//   final String userId;

//   AddBookParams({required this.book, required this.userId});

//   @override
//   List<Object> get props => [book, userId];
// }