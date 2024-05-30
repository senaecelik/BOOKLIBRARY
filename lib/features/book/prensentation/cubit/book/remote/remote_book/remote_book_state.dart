
// part of 'remote_book_cubit.dart';

// abstract class RemoteBookState extends Equatable{
//   final BookEntity? books;
//   final DioException? error;

//   const RemoteBookState(this.books, this.error);

//   @override
//   List<Object> get props => [books!, error!];
// }

// // class RemoteBookInitial extends RemoteBookState{
// //   const RemoteBookInitial() : super(null, null);
// // }
// class RemoteBookInitial extends RemoteBookState{
//   const RemoteBookInitial() : super(null, null);
// }

// class RemoteBookLoading extends RemoteBookState{
//   const RemoteBookLoading() : super(null, null);
// }

// class RemoteBookDone extends RemoteBookState{
//   const RemoteBookDone(BookEntity book) : super(book, null);

// }

// class RemoteBookError extends RemoteBookState{
// const RemoteBookError(DioException error): super(null, error);
// }