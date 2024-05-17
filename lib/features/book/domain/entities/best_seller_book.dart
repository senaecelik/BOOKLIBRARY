import 'package:equatable/equatable.dart';

class BestSellerBookEntity extends Equatable {
  final String? status;
  final String? copyright;
  final int? numResults;
  final String? lastModified;
  final List<ResultEntity>? results;

  const BestSellerBookEntity(
      {this.status,
      this.copyright,
      this.numResults,
      this.lastModified,
      this.results});

  @override
  List<Object?> get props =>
      [status, copyright, numResults, lastModified, results];
}

class ResultEntity extends Equatable {
  final String? listName;
  final String? displayName;
  final DateTime? bestsellersDate;
  final DateTime? publishedDate;
  final int? rank;
  final int? rankLastWeek;
  final int? weeksOnList;
  final int? asterisk;
  final int? dagger;
  final String? amazonProductUrl;
  final List<BookDetailEntity>? bookDetails;

  const ResultEntity({
    this.listName,
    this.displayName,
    this.bestsellersDate,
    this.publishedDate,
    this.rank,
    this.rankLastWeek,
    this.weeksOnList,
    this.asterisk,
    this.dagger,
    this.amazonProductUrl,
    this.bookDetails,
  });

  @override
  List<Object?> get props => [
        listName,
        displayName,
        bestsellersDate,
        publishedDate,
        rank,
        rankLastWeek,
        weeksOnList,
        asterisk,
        dagger,
        amazonProductUrl,
        bookDetails,
      ];
}

class BookDetailEntity extends Equatable {
  final String? title;
  final String? description;
  final String? contributor;
  final String? author;
  final String? contributorNote;
  final String? price;
  final String? ageGroup;
  final String? publisher;
  final String? primaryIsbn13;
  final String? primaryIsbn10;

  const BookDetailEntity(
      {this.title,
      this.description,
      this.contributor,
      this.author,
      this.contributorNote,
      this.price,
      this.ageGroup,
      this.publisher,
      this.primaryIsbn13,
      this.primaryIsbn10});

  @override
  List<Object?> get props => [
        title,
        description,
        contributor,
        author,
        contributorNote,
        price,
        ageGroup,
        publisher,
        primaryIsbn13,
        primaryIsbn10,
      ];
}
