import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/app/language/locale_keys.g.dart';
import 'package:flutter_project/app/router/app_router.dart';
import 'package:flutter_project/features/home/presentation/app_drawer.dart';
import 'package:flutter_project/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter_project/injection_container.dart';
import 'package:flutter_project/resources/values_manager.dart';
import 'package:iconsax/iconsax.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int currentPageIndex = 0;
  late HomeCubit homeCubit;

  final List<Map<String, dynamic>> chipsData = [
    {"label": "Okundu", "category": BookCategory.read},
    {"label": "Favoriler", "category": BookCategory.favBook},
    {"label": "Okunmadı", "category": BookCategory.unread},
    {"label": "Okumak İstiyorum", "category": BookCategory.wantRead},
  ];

  late final TextEditingController searchController;
  
bool isRefreshing = false;

  // Function to simulate refresh action
  Future<void> _refresh() async {
    setState(() {
      isRefreshing = true;
    });

    // Simulating network request
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isRefreshing = false;
    });
  }
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    homeCubit = sl<HomeCubit>();

    homeCubit.getWantToRead();
    // homeCubit.selectCategory(
    //     BookCategory.read); // Default olarak "Okundu" kategorisini seç
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeCubit,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(LocaleKeys.home_title.tr()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              useSafeArea: true,
              context: context,
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Iconsax.search_favorite),
                    title: const Text("Kitap adına göre ara"),
                    onTap: () {
                      context.router.push(const FindBookRoute());
                    },
                  ),
                  ListTile(
                    onTap: () {
                      context.router.push(const FindIsbnBookRoute());
                    },
                    leading: const Icon(Iconsax.barcode),
                    title: const Text("Kitap ISBN'sini ara"),
                  ),
                  const ListTile(
                    leading: Icon(Iconsax.book),
                    title: Text("Manuel olarak kitap ekle"),
                  ),
                ],
              ),
            );
          },
          child: const Icon(Iconsax.search_normal),
        ),
        drawer: const AppDrawer(),
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Iconsax.home_15),
              icon: Icon(Iconsax.home),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Iconsax.book),
              icon: Icon(Iconsax.book),
              label: 'Explore',
            ),
            NavigationDestination(
              selectedIcon: Icon(Iconsax.user),
              icon: Icon(Iconsax.archive_book),
              label: 'Library',
            ),
          ],
        ),
        body: <Widget>[
         Column(
  children: [
    ListTile(
      titleAlignment: ListTileTitleAlignment.titleHeight,
      title: const Text("Okumak istediklerim"),
      trailing: TextButton.icon(
        iconAlignment: IconAlignment.end,
        icon: const Icon(
          Iconsax.arrow_right_3,
          size: 16,
        ),
        label: const Text(
          "Tümünü gör",
        ),
        onPressed: () {},
      ),
    ),
    Expanded(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Column(
              children: [Icon(Iconsax.book)],
            );
          } else if (state is HomeDone) {
            return Column(
              children: [
                Expanded(
                  child: SizedBox(
                    child: RefreshIndicator.adaptive(
                      onRefresh: () async {
                        homeCubit.getWantToRead(); // Mevcut kategoriyi tekrar yükle
                      },
                      child: Stack(
                        children: [
                       GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              // Swipe right to refresh
              _refresh();
            }
          },
          child: SizedBox(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 10, // Replace with state.bookList.length
              itemBuilder: (context, index) {
                return Container(
                  width: 180, // Width of each book card
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            children: [
                              Image.network(
                                'https://via.placeholder.com/150',
                                fit: BoxFit.cover,
                                height: 250,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Book Title',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Author Name',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        if (isRefreshing)
          const Positioned(
            top: 10,
            left: 10,
            child: CircularProgressIndicator(),
          ), ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // İki bölüm arasına boşluk ekledik
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(44),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 7, // Gölgeyi belirginleştirdik
                          offset: Offset(2, 2), // Gölge
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16), // İçerik için padding ekledik
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Şuanda Okuduğum Kitap",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12), // Başlık ve içerik arasında boşluk
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Kitap Resmi
                            Stack(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.brown, // Rafın rengi
                                        width: 8,
                                      ),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12), // Resmin kenarlarını yuvarladık
                                    child: Image.network(
                                      "https://i.dr.com.tr/cache/600x600-0/originals/0000000064038-1.jpg", // Resim URL'si
                                      width: 150, // Resim genişliği
                                      height: 150, // Resim yüksekliği
                                      fit: BoxFit.contain, // Resmi kaplayacak şekilde ayarlama
                                    ),
                                  ),
                                ),
                                // Raf görünümünü oluşturan Container
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 8, // Raf yüksekliği
                                    color: Colors.brown[800], // Raf rengi
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 12), // Resim ile metin arasında boşluk
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Book Name", // Kitap adı
                                    style: Theme.of(context).textTheme.titleLarge,
                                    overflow: TextOverflow.ellipsis, // Uzun başlıklar için kesme
                                  ),
                                  const SizedBox(height: 4), // Kitap adı ve yazar arasında boşluk
                                  Text(
                                    "Author", // Yazar adı
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
                                    overflow: TextOverflow.ellipsis, // Uzun yazar isimleri için kesme
                                  ),
                                  const SizedBox(height: 32), // Metin ile bar arasında boşluk
                                  // Okuma ilerleme çubuğu
                                  const LinearProgressIndicator(
                                    value: 0.7, // Okunan sayfa oranı (örneğin %70)
                                    minHeight: 5, // Bar yüksekliği
                                  ),
                                  const SizedBox(height: 4), // Bar ile yüzde arasında boşluk
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "70%", // Okunan sayfa oranı
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is HomeError) {
            return RefreshIndicator.adaptive(
                onRefresh: () async {
                  homeCubit.getWantToRead();
                },
                child: ListView(children: [Text(state.message)]));
          } else {
            return const SizedBox();
          }
        },
      ),
    ),
  
              const SizedBox(
                height: 12,
              )
            ],
          ),
          const Text("Explore"),
          // Column(
          //   children: [_buildChipSelector(), _buildBookList()],
          // ),
        ][currentPageIndex],
      ),
    );
  }

  Widget _buildChipSelector() {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: chipsData.map((chipData) {
          return Padding(
            padding: EdgeInsets.only(left: AppPadding.p12),
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return ChoiceChip(
                  label: Text(chipData["label"]),
                  selected: homeCubit.selectedCategory == chipData["category"],
                  onSelected: (selected) {
                    if (selected) {
                      // homeCubit.selectCategory(
                      //     chipData["category"]); // Burada kategoriyi değiştir
                    }
                  },
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBookList() {
    return Expanded(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Column(
              children: [Icon(Iconsax.book)],
            );
          } else if (state is HomeDone) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                // homeCubit.selectCategory(homeCubit
                //     .selectedCategory); // Mevcut kategoriyi tekrar yükle
              },
              child: ListView.builder(
                itemCount: state.bookList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network(state.bookList[index].bookEntity
                            .imageLinks!.smallThumbnail ??
                        ""),
                    title:
                        Text(state.bookList[index].bookEntity.title.toString()),
                    subtitle: Text(state
                        .bookList[index].bookEntity.authors!.first
                        .toString()),
                    trailing: state.bookList[index].isFavorite == true
                        ? Icon(
                            Iconsax.heart5,
                            color: Theme.of(context).colorScheme.primary,
                          )
                        : const Icon(Iconsax.heart),
                    // Kitap bilgilerini burada daha fazla detay ile gösterin
                  );
                },
              ),
            );
          } else if (state is HomeError) {
            return Text(state.message);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
