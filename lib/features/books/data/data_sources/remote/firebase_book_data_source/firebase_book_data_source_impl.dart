import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/features/books/data/data_sources/remote/firebase_book_data_source/firebase_book_data_source.dart';
import 'package:flutter_project/features/books/data/model/book_detail_model.dart';
import 'package:flutter_project/features/books/data/model/book_model.dart';
import 'package:flutter_project/features/books/data/model/books_model.dart';
import 'package:flutter_project/features/books/data/model/image_link_model.dart';
import 'package:flutter_project/features/books/data/model/industry_identifier_model.dart';
import 'package:flutter_project/features/books/domain/entities/book_detail_entity.dart';
import 'package:flutter_project/features/books/domain/entities/book_entity.dart';

class RemoteBookDataSourceImpl extends RemoteBookDataSource {
  final FirebaseFirestore _firebaseFirestore;

  RemoteBookDataSourceImpl(this._firebaseFirestore);

  //Barkoddan gelen kitapları burada kaydetmek istiyoruzz.
  @override
  Future<void> createBook(BookEntityDetail book) async {
    final bookCollection = _firebaseFirestore.collection("book");

    final industryIdentifiers = book.industryIdentifiers?.map((identifier) {
      return IndustryIdentifierModel(
        type: identifier.type,
        identifier: identifier.identifier,
      );
    }).toList();

    final imageLinks = book.imageLinks != null
        ? ImageLinksModel.fromJson(book.imageLinks!.toJson())
        : null;

    final newBook = BookModelDetail(
            title: book.title,
            authors: book.authors,
            publishedDate: book.publishedDate,
            publisher: book.publisher,
            description: book.description,
            industryIdentifiers: industryIdentifiers,
            pageCount: book.pageCount,
            printType: book.printType,
            averageRating: book.averageRating,
            ratingsCount: book.ratingsCount,
            maturityRating: book.maturityRating,
            allowAnonLogging: book.allowAnonLogging,
            contentVersion: book.contentVersion,
            imageLinks: imageLinks,
            language: book.language,
            previewLink: book.previewLink,
            infoLink: book.infoLink,
            canonicalVolumeLink: book.canonicalVolumeLink,
            categories: book.categories)
        .toJson();

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