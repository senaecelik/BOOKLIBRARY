import 'package:flutter_project/features/books/domain/entities/item_entity.dart';

class BookEntity {
  final String? kind;
  final int? totalItems;
  final List<ItemEntity>? items;

  const BookEntity({
    this.kind,
    this.totalItems,
    this.items,
  });
}
