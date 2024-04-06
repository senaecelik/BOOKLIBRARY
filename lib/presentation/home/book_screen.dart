import 'package:flutter/material.dart';
import 'package:flutter_project/data/responses/book_response.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key, required this.bookModel});

  final BookModel bookModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("daf")
    );
  }
}
