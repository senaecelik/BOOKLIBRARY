import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/features/auth/domain/entity/user_static_model.dart';
import 'package:flutter_project/features/books/domain/entities/book_detail_entity.dart';
import 'package:flutter_project/features/books/presentation/cubit/book/remote/remote_book/remote_book_cubit.dart';
import 'package:flutter_project/features/user/domain/entity/add_book_entity.dart';

import 'package:flutter_project/features/user/presentation/cubit/user_mark_as_read_cubit.dart';
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
                                // AddToFavoriteButton(favoriteBook: state.books!),
                                MarkAsReadButton(
                                    bookEntityDetail: state.books!),
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

class MarkAsReadButton extends StatefulWidget {
  final BookEntityDetail bookEntityDetail;
  const MarkAsReadButton({
    super.key,
    required this.bookEntityDetail,
  });

  @override
  State<MarkAsReadButton> createState() => _MarkAsReadButtonState();
}

class _MarkAsReadButtonState extends State<MarkAsReadButton> {
  late UserMarkAsReadCubit _userMarkAsReadCubit;

  @override
  void initState() {
    _userMarkAsReadCubit = sl<UserMarkAsReadCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _userMarkAsReadCubit,
      child: BlocConsumer<UserMarkAsReadCubit, UserMarkAsReadState>(
        listener: (context, state) {
          if (state is UserMarkAsReadSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Favorilere eklendi")));
          } else if (state is UserMarkAsReadError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              IconButton(
                  onPressed: () {
                    AddBookEntity addBookEntity = AddBookEntity(
                        userId: UserStaticModel.uid!,
                        bookEntity: widget.bookEntityDetail);
                    _userMarkAsReadCubit.addFavorite(book: addBookEntity);
                  },
                  icon: const Icon(Iconsax.heart)),
              ElevatedButton.icon(
                icon: state is UserMarkAsReadLoading
                    ? const CircularProgressIndicator.adaptive()
                    : const Icon(Iconsax.save_2),
                onPressed: () {
                  AddBookEntity addBookEntity = AddBookEntity(
                      userId: UserStaticModel.uid!,
                      bookEntity: widget.bookEntityDetail);

                  _userMarkAsReadCubit.markAsReadBook(book: addBookEntity);
                },
                label: const Text("Okundu Olarak İşaretle"),
              ),

               ElevatedButton.icon(
                icon: state is UserMarkAsReadLoading
                    ? const CircularProgressIndicator.adaptive()
                    : const Icon(Iconsax.save_2),
                onPressed: () {
                  AddBookEntity addBookEntity = AddBookEntity(
                      userId: UserStaticModel.uid!,
                      bookEntity: widget.bookEntityDetail);

                  _userMarkAsReadCubit.addWantToRead(book: addBookEntity);
                },
                label: const Text("Okumak İstiyorum"),
              ),
            ],
          );
        },
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
  late UserMarkAsReadCubit _userMarkAsReadCubit;

  @override
  void initState() {
    _userMarkAsReadCubit = sl<UserMarkAsReadCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _userMarkAsReadCubit,
      child: BlocConsumer<UserMarkAsReadCubit, UserMarkAsReadState>(
        listener: (context, state) {
          if (state is UserMarkAsReadSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Favorilere eklendi")));
          } else if (state is UserMarkAsReadError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return IconButton(
              onPressed: () {
                AddBookEntity addBookEntity = AddBookEntity(
                    userId: UserStaticModel.uid!,
                    bookEntity: widget.favoriteBook);
                _userMarkAsReadCubit.addFavorite(book: addBookEntity);
              },
              icon: const Icon(Iconsax.heart));
        },
      ),
    );
  }
}
