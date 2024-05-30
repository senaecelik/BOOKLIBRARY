// import 'package:flutter_project/features/book/data/models/book.dart';
// import 'package:flutter_project/features/book/domain/usecases/add_book_to_bookshelf.dart';


// class BookshelfController {
//   final AddBookUseCase addBookUseCase;
//   // final UpdateBookUseCase updateBookUseCase;
//   // final DeleteBookUseCase deleteBookUseCase;
//   // final GetBooksUseCase getBooksUseCase;

//   BookshelfController({
//     required this.addBookUseCase,
//     // required this.updateBookUseCase,
//     // required this.deleteBookUseCase,
//     // required this.getBooksUseCase,
//   });
  
//   get updateBookUseCase => null;

//   Future<void> addBook(VolumeInfoModel book, String userId) async {
//     await addBookUseCase.call(params: AddBookParams(book: book, userId: userId));
//   }

//   // Future<void> updateBook(VolumeInfoModel book, String userId) async {
//   //   await updateBookUseCase.call(params: UpdateBookParams(book: book, userId: userId));
//   // }

//   // Future<void> deleteBook(String bookId, String userId) async {
//   //   await deleteBookUseCase.call(params: DeleteBookParams(bookId: bookId, userId: userId));
//   // }

//   // Future<List<VolumeInfoModel>> getBooks(String userId) async {
//   //   return await getBooksUseCase.call(params: GetBooksParams(userId: userId));
//   // }
// }
