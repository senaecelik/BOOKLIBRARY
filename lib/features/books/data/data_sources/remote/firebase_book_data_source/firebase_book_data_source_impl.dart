import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/features/books/data/data_sources/remote/firebase_book_data_source/firebase_book_data_source.dart';
import 'package:flutter_project/features/books/data/model/book_detail_model.dart';

import 'package:flutter_project/features/books/domain/entities/book_detail_entity.dart';

class RemoteBookDataSourceImpl extends RemoteBookDataSource {
  final FirebaseFirestore _firebaseFirestore;

  RemoteBookDataSourceImpl(this._firebaseFirestore);

  //Barkoddan gelen kitapları burada kaydetmek istiyoruzz.
  @override
  Future<void> createBook(BookEntityDetail book) async {
    final bookCollection = _firebaseFirestore.collection("book");

   
    final newBook = BookModelDetail.fromEntity(book).toJson();

    try {
      final bookDocumentRef =
          bookCollection.doc(book.industryIdentifiers!.first.identifier);
      final bookDocumentSnapshot = await bookDocumentRef.get();
      if (!bookDocumentSnapshot.exists) {
        await bookDocumentRef.set(newBook);
      } else {
        await bookDocumentRef.update(newBook);
      }
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Stream<List<BookModel>> readBooks(BookEntityDetail book) {
  //   final bookCollection = _firebaseFirestore
  //       .collection("books")
  //       .orderBy("createAt", descending: true);
  //   return bookCollection.snapshots().map((querySnapshot) => querySnapshot.docs
  //       .map((e) => BookModel.fromJson(e as Map<String, dynamic>))
  //       .toList());
  // }

}