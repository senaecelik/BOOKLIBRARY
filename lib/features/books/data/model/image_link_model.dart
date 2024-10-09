// ignore_for_file: overridden_fields

import 'package:flutter_project/features/books/domain/entities/image_links_entity.dart';

class ImageLinksModel extends ImageLinksEntity {
  @override
  final String? smallThumbnail;
  @override
  final String? thumbnail;

  const ImageLinksModel({
    this.smallThumbnail,
    this.thumbnail,
  });

  factory ImageLinksModel.fromJson(Map<String, dynamic> json) => ImageLinksModel(
      smallThumbnail: json["smallThumbnail"],
      thumbnail: json["thumbnail"]
    );

  Map<String, dynamic> toJson() => {
        'smallThumbnail': smallThumbnail,
        'thumbnail': thumbnail,
      };

      // fromEntity metodu ekleniyor
  factory ImageLinksModel.fromEntity(ImageLinksEntity entity) {
    return ImageLinksModel(
      smallThumbnail: entity.smallThumbnail,
      thumbnail: entity.thumbnail,
    );
  }
}
