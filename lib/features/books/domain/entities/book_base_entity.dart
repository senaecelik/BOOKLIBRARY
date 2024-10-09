import 'package:flutter_project/features/books/data/model/book_base_model.dart';
import 'package:flutter_project/features/books/data/model/image_link_model.dart';
import 'package:flutter_project/features/books/data/model/industry_identifier_model.dart';
import 'package:flutter_project/features/books/domain/entities/image_links_entity.dart';
import 'package:flutter_project/features/books/domain/entities/industry_identifier_entity.dart';

class BookBaseEntity {
  final String? title;
  final List<String>? authors;
  final List<IndustryIdentifierEntity>? industryIdentifiers;
  final ImageLinksEntity? imageLinks;
  final List<String>? categories;
  const BookBaseEntity({
    this.title,
    this.authors,
    this.industryIdentifiers,
    this.imageLinks,
    this.categories,
   
  });

  // Modelden Entity'e dönüşüm metodu
  static BookBaseModel fromEntity(BookBaseEntity entity) {
    return BookBaseModel(
      title: entity.title,
      authors: entity.authors,
    
      imageLinks: entity.imageLinks != null
          ? ImageLinksModel.fromEntity(entity.imageLinks!)
          : null,
      categories: entity.categories,
      industryIdentifiers: entity.industryIdentifiers?.map((id) => IndustryIdentifierModel.fromEntity(id))
              .toList(),
    );
  }
}
