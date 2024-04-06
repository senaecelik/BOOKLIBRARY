import 'package:json_annotation/json_annotation.dart';

part 'book_response.g.dart';

@JsonSerializable()
class BookModel {
  final bool status;
  final double time;
  final String desc;
  final List<BookResult> result;

  BookModel({required this.status, required this.time, required this.desc, required this.result});

  factory BookModel.fromJson(Map<String, dynamic> json) => _$BookModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookModelToJson(this);
}

@JsonSerializable()
class BookResult {
  final String title;
  final String author;
  final String publisher;
  final double isbn;
  final String image;

  BookResult({required this.title, required this.author, required this.publisher, required this.isbn, required this.image});

  factory BookResult.fromJson(Map<String, dynamic> json) => _$BookResultFromJson(json);
  Map<String, dynamic> toJson() => _$BookResultToJson(this);
}

@JsonSerializable()
class BookRequest{
  @JsonKey(name: "isbn")
  final String isbn;

  BookRequest({required this.isbn});

  factory BookRequest.fromJson(Map<String, dynamic> json) => _$BookRequestFromJson(json);
  Map<String, dynamic> toJson() => _$BookRequestToJson(this);
}