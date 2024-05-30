import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final String? kind;
  final int? totalItems;
  final List<ItemEntity>? items;

  const BookEntity({this.kind, this.totalItems, this.items});

  @override
  List<Object?> get props {
    return [kind, totalItems, items];
  }
}

class ItemEntity extends Equatable {
  final String? kind;
  final String? id;
  final String? etag;
  final String? selfLink;
  final VolumeInfoEntity? volumeInfo;
  // final SaleInfo? saleInfo;
  // final AccessInfo? accessInfo;
  // final SearchInfo? searchInfo;

  const ItemEntity({
    this.kind,
    this.id,
    this.etag,
    this.selfLink,
    this.volumeInfo,
    // this.saleInfo,
    // this.accessInfo,
    // this.searchInfo,
  });

  @override
  List<Object?> get props {
    return [
      kind,
      id,
      etag,
      selfLink,
      volumeInfo,
      //saleInfo, accessInfo,searchInfo
    ];
  }
}

class VolumeInfoEntity extends Equatable {
  final String? title;
  final List<String>? authors;
  final String? publisher;
  final String? publishedDate;
  final String? description;
  final List<IndustryIdentifierEntity>? industryIdentifiers;
  final int? pageCount;
  final String? printType;
  final double? averageRating;
  final int? ratingsCount;
  final String? maturityRating;
  final bool? allowAnonLogging;
  final String? contentVersion;
  final ImageLinksEntity? imageLinks;
  final String? language;
  final String? previewLink;
  final String? infoLink;
  final String? canonicalVolumeLink;
  final List<String>? categories;

  VolumeInfoEntity({
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

  @override
  List<Object?> get props => [
        title,
        authors,
        publishedDate,
        publisher,
        description,
        industryIdentifiers,
        pageCount,
        printType,
        averageRating,
        ratingsCount,
        maturityRating,
        allowAnonLogging,
        contentVersion,
        imageLinks,
        language,
        previewLink,
        infoLink,
        canonicalVolumeLink,
        categories
      ];
}

class ImageLinksEntity extends Equatable {
  final String? smallThumbnail;
  final String? thumbnail;

  const ImageLinksEntity({
    this.smallThumbnail,
    this.thumbnail,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [smallThumbnail, thumbnail];
}


class IndustryIdentifierEntity extends Equatable {
    final String? type;
    final String? identifier;

   const IndustryIdentifierEntity({
        this.type,
        this.identifier,
    });

    
      @override
      List<Object?> get props => [
        type,
        identifier
      ];
}