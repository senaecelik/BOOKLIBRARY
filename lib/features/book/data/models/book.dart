import 'package:flutter_project/features/book/domain/entities/book.dart';

// class BookModel extends BookEntity {
//   const BookModel({
//     int? id,
//   });

//   factory BookModel.fromJson(Map<String, dynamic> map){
//     return BookModel(
//       id: map['id'] ?? ""
//     );
//   }
// }

class BookModel extends BookEntity {
  final String? kind;
  final int? totalItems;
  final List<ItemModel>? items;

  const BookModel({
    this.kind,
    this.totalItems,
    this.items,
  });

  factory BookModel.fromJson(Map<String, dynamic> map) => BookModel(
        kind: map["kind"],
        totalItems: map["totalItems"],
        items: map["items"] == null
            ? []
            : List<ItemModel>.from(
                map["items"]!.map((x) => ItemModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "totalItems": totalItems,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class ItemModel extends ItemEntity {
  final String? kind;
  final String? id;
  final String? etag;
  final String? selfLink;
  final VolumeInfoModel? volumeInfo;

 const ItemModel({
    this.kind,
    this.id,
    this.etag,
    this.selfLink,
    this.volumeInfo,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        kind: json["kind"],
        id: json["id"],
        etag: json["etag"],
        selfLink: json["selfLink"],
        volumeInfo: json["volumeInfo"] == null
            ? null
            : VolumeInfoModel.fromJson(json["volumeInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "id": id,
        "etag": etag,
        "selfLink": selfLink,
        "volumeInfo": volumeInfo?.toJson(),
      };
}

class VolumeInfoModel extends VolumeInfoEntity {
  final String? title;
  final List<String>? authors;
  final String? publishedDate;
  final String? publisher;
  final String? description;
  final List<IndustryIdentifierModel>? industryIdentifiers;
  final int? pageCount;
  final String? printType;
  final double ? averageRating;
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

  VolumeInfoModel({
    this.title,
    this.authors,
    this.publisher,
    this.publishedDate,
  this. description,
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

  factory VolumeInfoModel.fromJson(Map<String, dynamic> json) =>
      VolumeInfoModel(
        title: json["title"],
        authors: json["authors"] == null
            ? []
            : List<String>.from(json["authors"]!.map((x) => x)),
        publishedDate: json["publishedDate"],
        publisher: json["publisher"],
        description: json["description"],
        industryIdentifiers: json["industryIdentifiers"] == null
            ? []
            : List<IndustryIdentifierModel>.from(json["industryIdentifiers"]!
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
            : List<String>.from(json["categories"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "authors":
            authors == null ? [] : List<dynamic>.from(authors!.map((x) => x)),
        "publishedDate":
           publishedDate,
          "publisher":publisher,
          "decription": description,
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
        "categories": categories == null ? []: List<dynamic>.from(categories!.map((x) => x))
      };
}

class ImageLinksModel extends ImageLinksEntity {
  final String? smallThumbnail;
  final String? thumbnail;

  ImageLinksModel({
    this.smallThumbnail,
    this.thumbnail,
  });

  factory ImageLinksModel.fromJson(Map<String, dynamic> json) =>
      ImageLinksModel(
        smallThumbnail: json["smallThumbnail"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "smallThumbnail": smallThumbnail,
        "thumbnail": thumbnail,
      };
}

class IndustryIdentifierModel extends IndustryIdentifierEntity {
  final String? type;
  final String? identifier;

  const IndustryIdentifierModel({
    this.type,
    this.identifier,
  });

  factory IndustryIdentifierModel.fromJson(Map<String, dynamic> json) =>
      IndustryIdentifierModel(
        type: json["type"],
        identifier: json["identifier"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "identifier": identifier,
      };
}
