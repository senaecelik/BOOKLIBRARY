import 'package:flutter_project/features/books/domain/entities/book_base_entity.dart';
import 'package:flutter_project/features/user/data/model/add_book_model.dart';

class AddBookEntity {
  final String userId;
  final BookBaseEntity bookEntity;
  final bool? isFavorite;
  

  AddBookEntity({
    required this.userId,
    required this.bookEntity,
    this.isFavorite,
  });



  // fromEntity metodu (Başka bir AddBookEntity'den dönüşüm)
  static AddBookModel fromEntity(AddBookEntity entity) {
    return AddBookModel(
      userId: entity.userId,
      bookEntity: BookBaseEntity.fromEntity(entity.bookEntity),
      isFavorite: entity.isFavorite,
    );
  }

  // toEntity metodu (Başka bir AddBookEntity'ye dönüşüm)

}
