import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/features/user/data/data_source/firebase_user_book_data_source/user_mark_as_read_data_source/user_mark_as_read_data_source.dart';
import 'package:flutter_project/features/user/data/model/add_book_model.dart';
import 'package:flutter_project/features/user/domain/entity/add_book_entity.dart';

class UserMarkAsReadDataSourceImpl extends UserMarkAsReadDataSource {
  final FirebaseFirestore _firebaseFirestore;

  UserMarkAsReadDataSourceImpl(this._firebaseFirestore);

  @override
  Future<void> markBookAsRead(AddBookEntity book) async {
    final markBookAsReadCollection = _firebaseFirestore
        .collection("users")
        .doc(book.userId)
        .collection("mark_book_as_read");

    final String bookId = book.bookEntity. industryIdentifiers?.isNotEmpty == true
        ? book.bookEntity. industryIdentifiers!.first.identifier!
        : book. bookEntity. title ?? DateTime.now().toString();

    // BookEntityDetail'den BookModelDetail'e dönüştürme
    final asReadBook = AddBookEntity.fromEntity(book).toJson();

    try {
      // Belgenin varlığını kontrol et
      final docSnapshot = await markBookAsReadCollection.doc(bookId).get();

      if (!docSnapshot.exists) {
        // Belge yoksa ekle
        await markBookAsReadCollection.doc(bookId).set(asReadBook);
      } else {
        throw "Kitap okundu olarak işaretlendi.";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addBookToFavoritesAndMarkAsRead(AddBookEntity book) async {
    final markBookAsReadCollection = _firebaseFirestore
        .collection("users")
        .doc(book.userId)
        .collection("mark_book_as_read");

    final String bookId = book.bookEntity.industryIdentifiers?.isNotEmpty == true
        ? book.bookEntity.industryIdentifiers!.first.identifier!
        : book.bookEntity.title ?? DateTime.now().toString();

    try {
      // Belgenin varlığını kontrol et
      final docSnapshot = await markBookAsReadCollection.doc(bookId).get();

      if (docSnapshot.exists) {
        // Kitap okunanlar içinde var, favori durumunu kontrol et
        final isFavorite = docSnapshot.data()?['isFavorite'] ?? false;

        if (isFavorite) {
          // Kitap zaten favorilere eklenmiş
          throw "Favorilere zaten eklenmiştir.";
        } else {
          // Favori yap
          await updateBookFavoriteStatus(book.userId, bookId, true);
        }
      } else {
        // Kitap okunanlar içinde yok, önce ekle sonra favori yap
        await markBookAsRead( book); // Öncelikle okunanlar listesine ekle
        await updateBookFavoriteStatus(book.userId, bookId, true); // Sonra favori yap
      }
    } catch (e) {
      rethrow; // Hata durumunu yönet
    }
  }

  @override
  Future<void> updateBookFavoriteStatus(String userId, String bookId, bool isFavorite) async {
    final markBookAsReadCollection = _firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("mark_book_as_read");

    try {
      // Belgeyi güncelle
      await markBookAsReadCollection.doc(bookId).update({
        'isFavorite': isFavorite,
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<AddBookModel>> getUserReadBooks(String userId) {
    final markBookAsReadCollection = _firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("mark_book_as_read");

    // Kullanıcının okuduğu kitapları dinle
    return markBookAsReadCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return AddBookModel.fromJson(doc.data());
      }).toList();
    });
  }

  @override
  Future<void> removeFromReadBooks(String userId, String bookId) async {
    
    final markBookAsReadCollection = _firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("mark_book_as_read");

    try {
      // Belgeyi sil
      await markBookAsReadCollection.doc(bookId).delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<AddBookModel>> getOnlyFavoriteReadBooks(String userId) {
    final markBookAsReadCollection = _firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("mark_book_as_read");

    // Kullanıcının yalnızca favori okuduğu kitapları dinle
    return markBookAsReadCollection.where('isFavorite', isEqualTo: true).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return AddBookModel.fromJson(doc.data());
      }).toList();
    });
  }

  @override
  Future<void> removeFromFavorites(String userId, String bookId) async {
    final markBookAsReadCollection = _firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("mark_book_as_read");

    try {
      // Favori durumunu false yap
      await updateBookFavoriteStatus(userId, bookId, false);
    } catch (e) {
      rethrow;
    }
  }
    @override
  Future<void> addToWantToRead(AddBookEntity book) async {
    final wantToReadCollection = _firebaseFirestore
        .collection("users")
        .doc(book.userId)
        .collection("want_to_read");

    final String bookId = book.bookEntity.industryIdentifiers?.isNotEmpty == true
        ? book.bookEntity.industryIdentifiers!.first.identifier!
        : book.bookEntity.title ?? DateTime.now().toString();

    // BookEntity'den AddBookModel'e dönüştürme
    final wantToReadBook = AddBookEntity.fromEntity(book).toJson();

    try {
      // Belgenin varlığını kontrol et
      final docSnapshot = await wantToReadCollection.doc(bookId).get();

      if (!docSnapshot.exists) {
        // Belge yoksa ekle
        await wantToReadCollection.doc(bookId).set(wantToReadBook);
      } else {
        throw "Kitap zaten 'Okumak İstiyorum' listesine eklenmiş.";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<AddBookModel>> getUserWantToReadBooks(String userId) {
    final wantToReadCollection = _firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("want_to_read");

    // Kullanıcının okumak istediği kitapları dinle
    return wantToReadCollection.snapshots().map((snapshot) {
      return  snapshot.docs.map((doc) {
  final data = doc.data();
  return AddBookModel.fromJson(data);
}).toList();

    });
  }

  @override
  Future<void> removeFromWantToRead(String userId, String bookId) async {
    final wantToReadCollection = _firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("want_to_read");

    try {
      // Belgeyi sil
      await wantToReadCollection.doc(bookId).delete();
    } catch (e) {
      rethrow;
    }
  }

}