import 'package:flutter_project/features/books/data/model/image_link_model.dart';
import 'package:flutter_project/features/books/domain/entities/book_base_entity.dart';
import 'package:flutter_project/features/books/domain/entities/image_links_entity.dart';
import 'package:flutter_project/features/books/domain/entities/industry_identifier_entity.dart';

class BookEntityDetail  extends BookBaseEntity{

  final String? publishedDate;
  final String? publisher;
  final String? description;
  final int? pageCount;
  final String? printType;
  final double? averageRating;
  final int? ratingsCount;
  final String? maturityRating;
  final bool? allowAnonLogging;
  final String? contentVersion;
  final String? language;
  final String? previewLink;
  final String? infoLink;
  final String? canonicalVolumeLink;

  const BookEntityDetail({
  
    this.publishedDate,
    this.publisher,
    this.description,
    this.pageCount,
    this.printType,
    this.averageRating,
    this.ratingsCount,
    this.maturityRating,
    this.allowAnonLogging,
    this.contentVersion,
    this.language,
    this.previewLink,
    this.infoLink,
    this.canonicalVolumeLink,
  });
}
