// ignore_for_file: overridden_fields

import 'package:flutter_project/features/books/data/model/book_detail_model.dart';
import 'package:flutter_project/features/books/domain/entities/item_entity.dart';

class ItemModel extends ItemEntity {
  @override
  final String? kind;
  @override
  final String? id;
  @override
  final String? etag;
  @override
  final String? selfLink;
  final BookModelDetail? bookModelDetail;

  const ItemModel({
    this.kind,
    this.id,
    this.etag,
    this.selfLink,
    this.bookModelDetail,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        kind: json["kind"],
        id: json["id"],
        etag: json["etag"],
        selfLink: json["selfLink"],
        bookModelDetail: json["volumeInfo"] == null
            ? null
            : BookModelDetail.fromJson(json["volumeInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "id": id,
        "etag": etag,
        "selfLink": selfLink,
        "volumeInfo": bookModelDetail?.toJson(),
      };
}
