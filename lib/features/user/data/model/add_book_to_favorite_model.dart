import 'package:flutter_project/features/books/data/model/book_base_model.dart';
import 'package:flutter_project/features/books/data/model/book_detail_model.dart';

class AddBookToFavoriteModel {
  final String userId;
  final BookBaseModel bookEntity; // Bu değişikliği yapmalısınız

  AddBookToFavoriteModel({
    required this.userId,
    required this.bookEntity,
  });

  factory AddBookToFavoriteModel.fromBookModelDetail(String userId, BookBaseModel bookModel) {
    return AddBookToFavoriteModel(
      userId: userId,
      bookEntity: bookModel,
    );
  }

  // JSON'dan oluşturma
  factory AddBookToFavoriteModel.fromJson(Map<String, dynamic> json) {
    return AddBookToFavoriteModel(
      userId: json['userId'] as String,
      bookEntity: BookBaseModel.fromJson(json['bookEntity'] as Map<String, dynamic>),
    );
  }

  // JSON'a çevirme
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'bookEntity': bookEntity.toJson(), // Burada da uygun toJson metodunu çağırmalısınız
    };
  }
}
