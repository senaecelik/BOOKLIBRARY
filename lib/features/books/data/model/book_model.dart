// ignore_for_file: overridden_fields

import 'package:flutter_project/features/books/domain/entities/books_entity.dart';
import 'item_model.dart';

class BookModel extends BookEntity {
  @override
  final String? kind;
  @override
  final int? totalItems;
  @override
  final List<ItemModel>? items;

  const BookModel({
    this.kind,
    this.totalItems,
    this.items,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        kind: json["kind"],
        totalItems: json["totalItems"],
        items: json["items"] == null
            ? []
            : List<ItemModel>.from(
                json["items"].map((x) => ItemModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "totalItems": totalItems,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}
