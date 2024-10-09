// ignore_for_file: overridden_fields

import 'package:flutter_project/features/books/data/model/book_base_model.dart';
import 'package:flutter_project/features/user/domain/entity/add_book_entity.dart';

class AddBookModel extends AddBookEntity {
  @override
  final String userId;
  @override
  final BookBaseModel bookEntity; // Model sınıfı
  @override
  final bool? isFavorite;

   AddBookModel({
    required this.userId,
    required this.bookEntity,
    this.isFavorite,
  }) : super(userId: userId, bookEntity: bookEntity);

  // toJson metodu
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'bookEntity': bookEntity.toJson(), // BookBaseModel'in toJson'u çağrılır
      'isFavorite': isFavorite ?? false,
    };
  }

  // fromJson metodu
  factory AddBookModel.fromJson(Map<String, dynamic> json) {
    return AddBookModel(
      userId: json['userId'],
      bookEntity: BookBaseModel.fromJson(json['bookEntity']), // BookBaseModel'in fromJson'u çağrılır
      isFavorite: json['isFavorite'] ?? false,
    );
  }


}
