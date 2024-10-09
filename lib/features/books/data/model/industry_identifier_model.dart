// ignore_for_file: overridden_fields

import 'package:flutter_project/features/books/domain/entities/industry_identifier_entity.dart';

class IndustryIdentifierModel extends IndustryIdentifierEntity {
  @override
  final String? type;
  @override
  final String? identifier;

  const IndustryIdentifierModel({
    this.type,
    this.identifier,
  });

  factory IndustryIdentifierModel.fromJson(Map<String, dynamic> json) {
    return IndustryIdentifierModel(
      type: json['type'],
      identifier: json['identifier'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'identifier': identifier,
    };
  }
  // fromEntity metodu ekleniyor
  factory IndustryIdentifierModel.fromEntity(IndustryIdentifierEntity entity) {
    return IndustryIdentifierModel(
      type: entity.type,
      identifier: entity.identifier,
    );
  }
}
