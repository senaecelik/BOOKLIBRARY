import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/features/book/data/data_sources/remote/book_shelf_data_source.dart';
import 'package:flutter_project/features/book/data/models/book.dart';

class BookshelfDataSourceImpl implements BookshelfDataSource {
  final FirebaseFirestore firestore;

  BookshelfDataSourceImpl(this.firestore);

  @override
  Future<void> addBook(VolumeInfoModel book, String userId) async {
    await firestore.collection('users').doc(userId).collection('books').add(book.toJson());
  }

  @override
  Future<void> updateBook(VolumeInfoModel book, String userId) async {
    await firestore.collection('users').doc(userId).collection('books').doc(book.industryIdentifiers!.first.identifier).update(book.toJson());
  }

  @override
  Future<void> deleteBook(String bookId, String userId) async {
    await firestore.collection('users').doc(userId).collection('books').doc(bookId).delete();
  }

  @override
  Future<List<VolumeInfoModel>> getBooks(String userId) async {
    final querySnapshot = await firestore.collection('users').doc(userId).collection('books').get();
    return querySnapshot.docs.map((doc) => VolumeInfoModel.fromJson(doc.data())).toList();
  }
}