// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map<String, dynamic> json) => BookModel(
      status: json['status'] as bool,
      time: (json['time'] as num).toDouble(),
      desc: json['desc'] as String,
      result: (json['result'] as List<dynamic>)
          .map((e) => BookResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
      'status': instance.status,
      'time': instance.time,
      'desc': instance.desc,
      'result': instance.result,
    };

BookResult _$BookResultFromJson(Map<String, dynamic> json) => BookResult(
      title: json['title'] as String,
      author: json['author'] as String,
      publisher: json['publisher'] as String,
      isbn: (json['isbn'] as num).toDouble(),
      image: json['image'] as String,
    );

Map<String, dynamic> _$BookResultToJson(BookResult instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'publisher': instance.publisher,
      'isbn': instance.isbn,
      'image': instance.image,
    };

BookRequest _$BookRequestFromJson(Map<String, dynamic> json) => BookRequest(
      isbn: json['isbn'] as String,
    );

Map<String, dynamic> _$BookRequestToJson(BookRequest instance) =>
    <String, dynamic>{
      'isbn': instance.isbn,
    };
