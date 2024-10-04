import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/features/auth/domain/entity/user_static_model.dart';
import 'package:flutter_project/features/books/data/model/book_detail_model.dart';
import 'package:flutter_project/features/books/domain/entities/book_detail_entity.dart';
import 'package:flutter_project/features/user/data/data_source/firebase_user_book_data_source/user_book_data_source.dart';
import 'package:flutter_project/features/books/presentation/cubit/book/remote/remote_book/remote_book_cubit.dart';
import 'package:flutter_project/features/user/data/model/add_book_to_favorite_model.dart';
import 'package:flutter_project/features/user/presentation/cubit/add_book_to_favorite_cubit.dart';
import 'package:flutter_project/injection_container.dart';
import 'package:iconsax/iconsax.dart';

@RoutePage()
class FindIsbnBookScreen extends StatefulWidget {
  const FindIsbnBookScreen({super.key});

  @override
  State<FindIsbnBookScreen> createState() => _FindIsbnBookScreenState();
}

class _FindIsbnBookScreenState extends State<FindIsbnBookScreen> {
  late RemoteBookCubit _remoteBookCubit;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _remoteBookCubit = sl<RemoteBookCubit>();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SearchBar(
                controller: _searchController,
                hintText: 'ISBN girin',
                leading: const Icon(Icons.search),
                onSubmitted: (value) {
                  _remoteBookCubit.onGetBook(query: value); // ISBN ile arama
                },
                trailing: {
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                    },
                  )
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<RemoteBookCubit, RemoteBookState>(
                bloc: _remoteBookCubit,
                builder: (context, state) {
                  if (state is RemoteBookLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is RemoteBookDone) {
                    final book = state.books;
                    if (book == null) {
                      return const Center(child: Text("Kitap bulunamadı."));
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (book.imageLinks?.smallThumbnail != null)
                              Center(
                                child: Image.network(
                                  book.imageLinks!.smallThumbnail!,
                                  height: 200,
                                ),
                              ),
                            const SizedBox(height: 20),
                            Text(
                              book.title ?? "Başlık yok",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Yazarlar: ${book.authors?.join(', ') ?? 'Yazar bilgisi yok'}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Yayınevi: ${book.publisher ?? 'Yayınevi bilgisi yok'}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Yayın Tarihi: ${book.publishedDate ?? 'Tarih bilgisi yok'}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                AddToFavoriteButton(favoriteBook: state.books!),
                                ElevatedButton(
                                  onPressed: () {
                                    // Okundu olarak işaretle
                                    final userBookDataSource =
                                        sl<UserBookDataSource>();
                                    userBookDataSource.markBookAsRead(
                                        UserStaticModel.uid!, book);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Kitap okundu olarak işaretlendi.")),
                                    );
                                  },
                                  child: const Text("Okundu Olarak İşaretle"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  } else if (state is RemoteBookError) {
                    return const Center(
                      child: Text("Bir hata oluştu:"),
                    );
                  }
                  return const Center(
                      child: Text("Bir ISBN girin ve arama yapın."));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddToFavoriteButton extends StatefulWidget {
  final BookEntityDetail favoriteBook;
  const AddToFavoriteButton({
    super.key,
    required this.favoriteBook,
  });

  @override
  State<AddToFavoriteButton> createState() => _AddToFavoriteButtonState();
}

class _AddToFavoriteButtonState extends State<AddToFavoriteButton> {
  late AddBookToFavoriteCubit _addBookToFavoriteCubit;

  @override
  void initState() {
    _addBookToFavoriteCubit = sl<AddBookToFavoriteCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _addBookToFavoriteCubit,
      child: BlocConsumer<AddBookToFavoriteCubit, AddBookToFavoriteState>(
        listener: (context, state) {
          if (state is AddBookToFavoriteDone) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AddBookToFavoriteError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return FilledButton.icon(
            icon: state is AddBookToFavoriteLoading ? CircularProgressIndicator.adaptive(): Icon(Iconsax.heart),
            onPressed: () {
              // Favorilere ekle
              _addBookToFavoriteCubit.addBookToFavorite(widget.favoriteBook);
            },
            label: const Text("Favorilere Ekle"),
          );
        },
      ),
    );
  }
}
