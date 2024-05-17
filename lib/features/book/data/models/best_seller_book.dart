
import 'package:flutter_project/features/book/domain/entities/best_seller_book.dart';

class BestSellerBookModel extends BestSellerBookEntity{
    final String? status;
    final String? copyright;
    final int? numResults;
    final String? lastModified;
    final List<Result>? results;

    BestSellerBookModel({
        this.status,
        this.copyright,
        this.numResults,
        this.lastModified,
        this.results,
    });

    factory BestSellerBookModel.fromJson(Map<String, dynamic> json) => BestSellerBookModel(
        status: json["status"],
        copyright: json["copyright"],
        numResults: json["num_results"],
        lastModified: json["last_modified"],
        results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "copyright": copyright,
        "num_results": numResults,
        "last_modified": lastModified,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class Result extends ResultEntity{
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
    final List<BookDetail>? bookDetails;

    Result({
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

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        listName: json["list_name"],
        displayName: json["display_name"],
        bestsellersDate: json["bestsellers_date"] == null ? null : DateTime.parse(json["bestsellers_date"]),
        publishedDate: json["published_date"] == null ? null : DateTime.parse(json["published_date"]),
        rank: json["rank"],
        rankLastWeek: json["rank_last_week"],
        weeksOnList: json["weeks_on_list"],
        asterisk: json["asterisk"],
        dagger: json["dagger"],
        amazonProductUrl: json["amazon_product_url"],
        bookDetails: json["book_details"] == null ? [] : List<BookDetail>.from(json["book_details"]!.map((x) => BookDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "list_name": listName,
        "display_name": displayName,
        "bestsellers_date": "${bestsellersDate!.year.toString().padLeft(4, '0')}-${bestsellersDate!.month.toString().padLeft(2, '0')}-${bestsellersDate!.day.toString().padLeft(2, '0')}",
        "published_date": "${publishedDate!.year.toString().padLeft(4, '0')}-${publishedDate!.month.toString().padLeft(2, '0')}-${publishedDate!.day.toString().padLeft(2, '0')}",
        "rank": rank,
        "rank_last_week": rankLastWeek,
        "weeks_on_list": weeksOnList,
        "asterisk": asterisk,
        "dagger": dagger,
        "amazon_product_url": amazonProductUrl,
        "book_details": bookDetails == null ? [] : List<dynamic>.from(bookDetails!.map((x) => x.toJson())),
    };
}

class BookDetail extends BookDetailEntity {
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

    BookDetail({
        this.title,
        this.description,
        this.contributor,
        this.author,
        this.contributorNote,
        this.price,
        this.ageGroup,
        this.publisher,
        this.primaryIsbn13,
        this.primaryIsbn10,
    });

    factory BookDetail.fromJson(Map<String, dynamic> json) => BookDetail(
        title: json["title"],
        description: json["description"],
        contributor: json["contributor"],
        author: json["author"],
        contributorNote: json["contributor_note"],
        price: json["price"],
        ageGroup: json["age_group"],
        publisher: json["publisher"],
        primaryIsbn13: json["primary_isbn13"],
        primaryIsbn10: json["primary_isbn10"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "contributor": contributor,
        "author": author,
        "contributor_note": contributorNote,
        "price": price,
        "age_group": ageGroup,
        "publisher": publisher,
        "primary_isbn13": primaryIsbn13,
        "primary_isbn10": primaryIsbn10,
    };
}

