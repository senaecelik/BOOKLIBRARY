import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/features/books/domain/entities/book_base_entity.dart';
import 'package:flutter_project/features/user/data/data_source/firebase_user_book_data_source/user_book_data_source.dart';
import 'package:flutter_project/features/books/data/model/book_detail_model.dart';
import 'package:flutter_project/features/books/data/model/industry_identifier_model.dart';
import 'package:flutter_project/features/books/domain/entities/book_detail_entity.dart';

class UserBookDataSourceImpl extends UserBookDataSource {
  final FirebaseFirestore _firebaseFirestore;

  UserBookDataSourceImpl(this._firebaseFirestore);

  @override
  Future<void> addBookToFavorites(String userId, BookBaseEntity book) async {
    final favoritesCollection = _firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("favorite_books");

    final String bookId = book.industryIdentifiers?.isNotEmpty == true
        ? book.industryIdentifiers!.first.identifier!
        : book.title ?? DateTime.now().toString();

    // BookEntityDetail'den BookModelDetail'e dönüştürme
    final favBook = BookBaseEntity.fromEntity(book).toJson();

    try {
      // Belgenin varlığını kontrol et
      final docSnapshot = await favoritesCollection.doc(bookId).get();

      if (!docSnapshot.exists) {
        // Belge yoksa ekle
        await favoritesCollection.doc(bookId).set(favBook);
      } else {
        throw "Kitap zaten favorilerde mevcut.";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> markBookAsRead(String userId, BookBaseEntity book) async {
    final readBooksCollection = _firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("read_books");

    final String bookId = book.industryIdentifiers?.isNotEmpty == true
        ? book.industryIdentifiers!.first.identifier!
        : book.title ?? DateTime.now().toString();

    final industryIdentifiers = book.industryIdentifiers?.map((identifier) {
      return IndustryIdentifierModel(
        type: identifier.type,
        identifier: identifier.identifier,
      );
    }).toList();

    final readBook = BookModelDetail(
      title: book.title,
      authors: book.authors,
      industryIdentifiers: industryIdentifiers,
    ).toJson();

    try {
      await readBooksCollection.doc(bookId).set(readBook);
      print("Kitap okundu olarak işaretlendi.");
    } catch (e) {
      print("Kitap okunmuş olarak işaretlenirken hata oluştu: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> addToWantToRead(String userId, BookBaseEntity book) async {
    final wantToReadCollection = _firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("want_to_read_books");

    final String bookId = book.industryIdentifiers?.isNotEmpty == true
        ? book.industryIdentifiers!.first.identifier!
        : book.title ?? DateTime.now().toString();

    final industryIdentifiers = book.industryIdentifiers?.map((identifier) {
      return IndustryIdentifierModel(
        type: identifier.type,
        identifier: identifier.identifier,
      );
    }).toList();

    final wantToReadBook = BookModelDetail(
      title: book.title,
      authors: book.authors,
      industryIdentifiers: industryIdentifiers,
    ).toJson();

    try {
      await wantToReadCollection.doc(bookId).set(wantToReadBook);
      print("Kitap 'Okunacaklar' listesine eklendi.");
    } catch (e) {
      print(
          "Kitap okunacaklar listesine eklenirken hata oluştu: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> removeBookFromFavorites(String userId, String bookId) async {
    final favoritesCollection = _firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("favorite_books");

    await favoritesCollection.doc(bookId).delete();
  }

  @override
  Future<void> removeFromWantToRead(String userId, String bookId) async {
    final wantToReadCollection = _firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("want_to_read_books");

    await wantToReadCollection.doc(bookId).delete();
  }

  @override
  Future<void> removeFromReadBooks(String userId, String bookId) async {
    final readBooksCollection = _firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("read_books");

    await readBooksCollection.doc(bookId).delete();
  }

  @override
  Stream<List<BookModelDetail>> getUserReadBooks(String userId) {
    return _firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("read_books")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                BookModelDetail.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  @override
  Stream<List<BookModelDetail>> getUserFavoriteBooks(String userId) {
    return _firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("favorite_books")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                BookModelDetail.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  @override
  Stream<List<BookModelDetail>> getUserWantToReadBooks(String userId) {
    return _firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("want_to_read_books")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                BookModelDetail.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }
}
