import 'package:flutter_project/features/books/data/model/image_link_model.dart';
import 'package:flutter_project/features/books/domain/entities/image_links_entity.dart';
import 'package:flutter_project/features/books/domain/entities/industry_identifier_entity.dart';

class BookEntityDetail {
  final String? title;
  final List<String>? authors;
  final String? publishedDate;
  final String? publisher;
  final String? description;
  final List<IndustryIdentifierEntity>? industryIdentifiers;
  final int? pageCount;
  final String? printType;
  final double? averageRating;
  final int? ratingsCount;
  final String? maturityRating;
  final bool? allowAnonLogging;
  final String? contentVersion;
  final ImageLinksModel? imageLinks;
  final String? language;
  final String? previewLink;
  final String? infoLink;
  final String? canonicalVolumeLink;
  final List<String>? categories;

  const BookEntityDetail({
    this.title,
    this.authors,
    this.publishedDate,
    this.publisher,
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
}
