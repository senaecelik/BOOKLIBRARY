import 'package:flutter_project/features/books/data/model/image_link_model.dart';
import 'package:flutter_project/features/books/data/model/industry_identifier_model.dart';
import 'package:flutter_project/features/books/domain/entities/book_base_entity.dart';

class BookBaseModel extends BookBaseEntity {
  final String? title;
  final List<String>? authors;
  final ImageLinksModel? imageLinks;
  final List<String>? categories;
  final List<IndustryIdentifierModel>? industryIdentifiers;

  const BookBaseModel({
    this.title,
    this.authors,
    this.imageLinks,
    this.categories,
    this.industryIdentifiers,
  });

  factory BookBaseModel.fromJson(Map<String, dynamic> json) => BookBaseModel(
        title: json["title"],
        authors: json["authors"] == null
            ? []
            : List<String>.from(json["authors"].map((x) => x)),
      
        imageLinks: json["imageLinks"] == null
            ? null
            : ImageLinksModel.fromJson(json["imageLinks"]),
        categories: json["categories"] == null
            ? []
            : List<String>.from(json["categories"].map((x) => x)),
        industryIdentifiers: json["industryIdentifiers"] == null
            ? []
            : List<IndustryIdentifierModel>.from(json["industryIdentifiers"]
                .map((x) => IndustryIdentifierModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "authors":
            authors == null ? [] : List<dynamic>.from(authors!.map((x) => x)),
        "imageLinks": imageLinks?.toJson(),
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x)),
        "industryIdentifiers": industryIdentifiers == null
            ? []
            : List<dynamic>.from(industryIdentifiers!.map((x) => x.toJson())),
      };


}
