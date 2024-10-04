import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FindBookScreen extends StatefulWidget {
  const FindBookScreen({super.key});

  @override
  State<FindBookScreen> createState() => _FindBookScreenState();
}

class _FindBookScreenState extends State<FindBookScreen> {
  late TextEditingController _searchController;

  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 150) {
        if (!_isScrolled) {
          setState(() {
            _isScrolled = true;
          });
        }
      } else {
        if (_isScrolled) {
          setState(() {
            _isScrolled = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              collapsedHeight: 65,
              expandedHeight: 170,
              toolbarHeight: 60,
              floating: false,
              pinned: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                titlePadding: _isScrolled
                    ? const EdgeInsets.only(top: 10, bottom: 12, left: 50, right: 10)
                    : const EdgeInsets.only(top: 80, left: 20),
                title: AnimatedOpacity(
                    opacity: _isScrolled ? 1.0 : 0.8,
                    duration: const Duration(milliseconds: 300),
                    child: _isScrolled
                        ? SearchBar(
                          elevation: const WidgetStatePropertyAll(1),
                          controller: _searchController,
                          onChanged:(value) {
                            
                          },
                            leading: const Icon(Icons.search),
                            trailing: {const Icon(Icons.clear)},
                          )
                        : Align(
                            alignment: Alignment.centerLeft,
                            child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 5000),
                                opacity: _isScrolled ? 0.5 : 1.0,
                                child: Text(
                                  "Kitap ara!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant),
                                )),
                          )),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    if (!_isScrolled) const SearchBar(),
                    // Diğer içerikler buraya eklenebilir
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ListTile(
                    title: Text("List Item $index"),
                  );
                },
                childCount: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class SearchBar extends StatelessWidget {
//   final bool isAppBar;

//   SearchBar({this.isAppBar = false});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white, // Arka plan rengini beyaz olarak ayarla
//         borderRadius: isAppBar
//             ? BorderRadius.circular(0)
//             : BorderRadius.circular(RadiusManager.medium.value),
//       ),
//       child: TextField(
//         onChanged: (value){

//         },
//         decoration: InputDecoration(
//             hintText: 'Search...',
//             prefixIcon: Icon(Icons.search),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(RadiusManager.medium.value),
//               borderSide: BorderSide.none,
//             ),
            
//             filled: true,
//             contentPadding: EdgeInsets.all(16.0),
//             fillColor: Theme.of(context).colorScheme.secondaryContainer),

//         // Arka plan rengini beyaz olarak ayarla
//       ),
//     );
//   }
// }

// class BookDetailScreen extends StatefulWidget {
//   const BookDetailScreen({super.key, required this.bookEntity});
//   final BookModelDetail bookEntity;

//   @override
//   State<BookDetailScreen> createState() => _BookDetailScreenState();
// }

// class _BookDetailScreenState extends State<BookDetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: EdgeInsets.all(AppPadding.pagePadding),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 widget.bookEntity.imageLinks != null
//                     ? Image.network(
//                         widget.bookEntity.imageLinks!.thumbnail!,
//                         height: MediaQuery.of(context).size.height * .2,
//                         fit: BoxFit
//                             .cover, // Ensure the image covers the entire area
//                       )
//                     : SizedBox(
//                         height: MediaQuery.of(context).size.height * .2,
//                         child: Center(child: Icon(Icons.book))),
//                 Expanded(
//                     child: Column(
//                   children: [
//                     ListTile(
//                       titleTextStyle: Theme.of(context).textTheme.headlineSmall,
//                       subtitleTextStyle: Theme.of(context).textTheme.titleSmall,
//                       title: Text(widget.bookEntity.title ?? "N/A"),
//                       isThreeLine: true,
//                       subtitle: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Wrap(
//                             spacing: 1, // Add some spacing between the items
//                             // Add some spacing between the lines
//                             children: widget.bookEntity.authors!.map((author) {
//                               bool isLastAuthor =
//                                   widget.bookEntity.authors!.last == author;

//                               return Text(isLastAuthor ? author : '$author,');
//                             }).toList(),
//                           ),
//                           Text("${widget.bookEntity.pageCount!} pages"),
//                           OutlinedButton(
//                               onPressed: () {}, child: Text("Rafa Ekle"))
//                         ],
//                       ),
//                     ),
//                   ],
//                 ))
//               ],
//             ),
//             Divider(),
//             Text(
//               "${widget.bookEntity.description!}",
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyMedium!
//                   .copyWith(color: Theme.of(context).colorScheme.onSecondary),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
