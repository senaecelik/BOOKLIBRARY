import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/app/api_constant.dart';
import 'package:flutter_project/core/client/network_client.dart';
import 'package:flutter_project/data/repository/book_repository.dart';
import 'package:flutter_project/presentation/home/search_isbn/cubit/search_isbn_cubit.dart';
import 'package:flutter_project/presentation/home/search_isbn/search_isbn_screen.dart';

mixin SearchIsbnMixin on State<SearchIsbnScreen> {
  late final SearchIsbnCubit _searchIsbnViewModel;
  late final NetworkClient _networkManager;

  SearchIsbnCubit get searchIsbnViewModel => _searchIsbnViewModel;

  @override
  void initState() {
    _networkManager = NetworkClient(dio: Dio(), baseUrl: ApiConstant.baseUrl);
    _searchIsbnViewModel = SearchIsbnCubit(bookRepository: BookRepository(_networkManager));
    _searchIsbnViewModel.query(isbn: "9789750718533");

    super.initState();
  }
}
