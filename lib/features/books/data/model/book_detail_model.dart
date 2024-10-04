import 'package:flutter_project/features/books/data/model/image_link_model.dart';
import 'package:flutter_project/features/books/data/model/industry_identifier_model.dart';
import 'package:flutter_project/features/books/domain/entities/book_detail_entity.dart';

class BookModelDetail extends BookEntityDetail {
  @override
  final String? title;
  @override
  final List<String>? authors;
  @override
  final String? publishedDate;
  @override
  final String? publisher;
  @override
  final String? description;
  @override
  final List<IndustryIdentifierModel>? industryIdentifiers;
  @override
  final int? pageCount;
  @override
  final String? printType;
  @override
  final double? averageRating;
  @override
  final int? ratingsCount;
  @override
  final String? maturityRating;
  @override
  final bool? allowAnonLogging;
  @override
  final String? contentVersion;
  @override
  final ImageLinksModel? imageLinks;
  @override
  final String? language;
  @override
  final String? previewLink;
  @override
  final String? infoLink;
  @override
  final String? canonicalVolumeLink;
  @override
  final List<String>? categories;

  const BookModelDetail({
    this.title,
    this.authors,
    this.publisher,
    this.publishedDate,
    this.description,
    this.industryIdentifiers,
    this.pageCount,
    this.printType,
    this.averageRating,
    this.ratingsCount,
    this.maturityRating,
    this.allowAnonLogging,
    this.contentVersion,
    this.imageLinks,
    this.language,
    this.previewLink,
    this.infoLink,
    this.canonicalVolumeLink,
    this.categories,
  });

  factory BookModelDetail.fromJson(Map<String, dynamic> json) =>
      BookModelDetail(
        title: json["title"],
        authors: json["authors"] == null
            ? []
            : List<String>.from(json["authors"].map((x) => x)),
        publishedDate: json["publishedDate"],
        publisher: json["publisher"],
        description: json["description"],
        industryIdentifiers: json["industryIdentifiers"] == null
            ? []
            : List<IndustryIdentifierModel>.from(json["industryIdentifiers"]
                .map((x) => IndustryIdentifierModel.fromJson(x))),
        pageCount: json["pageCount"],
        printType: json["printType"],
        averageRating: json["averageRating"]?.toDouble(),
        ratingsCount: json["ratingsCount"],
        maturityRating: json["maturityRating"],
        allowAnonLogging: json["allowAnonLogging"],
        contentVersion: json["contentVersion"],
        imageLinks: json["imageLinks"] == null
            ? null
            : ImageLinksModel.fromJson(json["imageLinks"]),
        language: json["language"],
        previewLink: json["previewLink"],
        infoLink: json["infoLink"],
        canonicalVolumeLink: json["canonicalVolumeLink"],
        categories: json["categories"] == null
            ? []
            : List<String>.from(json["categories"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "authors":
            authors == null ? [] : List<dynamic>.from(authors!.map((x) => x)),
        "publishedDate": publishedDate,
        "publisher": publisher,
        "description": description,
        "industryIdentifiers": industryIdentifiers == null
            ? []
            : List<dynamic>.from(industryIdentifiers!.map((x) => x.toJson())),
        "pageCount": pageCount,
        "printType": printType,
        "averageRating": averageRating,
        "ratingsCount": ratingsCount,
        "maturityRating": maturityRating,
        "allowAnonLogging": allowAnonLogging,
        "contentVersion": contentVersion,
        "imageLinks": imageLinks?.toJson(),
        "language": language,
        "previewLink": previewLink,
        "infoLink": infoLink,
        "canonicalVolumeLink": canonicalVolumeLink,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x)),
      };
factory BookModelDetail.fromEntity(BookEntityDetail entity) {
  return BookModelDetail(
    title: entity.title,
    authors: entity.authors ?? [],
    publishedDate: entity.publishedDate,
    publisher: entity.publisher,
    description: entity.description,
    industryIdentifiers: entity.industryIdentifiers == null
        ? []
        : entity.industryIdentifiers!.map((id) => IndustryIdentifierModel.fromEntity(id)).toList(),
    pageCount: entity.pageCount,
    printType: entity.printType,
    averageRating: entity.averageRating,
    ratingsCount: entity.ratingsCount,
    maturityRating: entity.maturityRating,
    allowAnonLogging: entity.allowAnonLogging,
    contentVersion: entity.contentVersion,
    imageLinks: entity.imageLinks != null ? ImageLinksModel.fromEntity(entity.imageLinks!) : null,
    language: entity.language,
    previewLink: entity.previewLink,
    infoLink: entity.infoLink,
    canonicalVolumeLink: entity.canonicalVolumeLink,
    categories: entity.categories ?? [],
  );
}

}
