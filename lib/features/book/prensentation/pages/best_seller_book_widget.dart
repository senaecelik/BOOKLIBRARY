// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_project/features/book/domain/entities/book.dart';
// import 'package:flutter_project/features/book/prensentation/cubit/book/remote/remote_best_seller_book/remote_best_seller_book_cubit.dart';
// import 'package:flutter_project/features/book/prensentation/cubit/book/remote/remote_book/remote_book_cubit.dart';
// import 'package:flutter_project/injection_container.dart';
// import 'package:flutter_project/resources/font_manager.dart';
// import 'package:flutter_project/resources/values_manager.dart';

// class BestSellerBookWidget extends StatefulWidget {
//   const BestSellerBookWidget({super.key});

//   @override
//   State<BestSellerBookWidget> createState() => _BestSellerBookWidgetState();
// }

// class _BestSellerBookWidgetState extends State<BestSellerBookWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<RemoteBestSellerBookCubit>(
//       create: (context) => sl()..onGetBestSellerBook(),
//       child: _buildBody(),
//     );
//   }

//   _buildBody() {
//     return Column(
//       children: [
//         SizedBox(
//           child:
//               BlocBuilder<RemoteBestSellerBookCubit, RemoteBestSellerBookState>(
//             builder: (context, state) {
//               debugPrint(state.toString());
//               if (state is RemoteBestSellerBookLoading) {
//                 return Center(
//                   child: CupertinoActivityIndicator(),
//                 );
//               }
//               if (state is RemoteBestSellerBookDone) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SearchBar(
//                       constraints: BoxConstraints(minHeight: 48),
//                       onSubmitted: (value) {
//                         context.read<RemoteBookCubit>().onGetBook(query: value);
//                       },
//                       hintText:
//                           "Kelimeye göre veya ISBN'ye göre arama yapabilirsiniz.",
//                       leading: Icon(Icons.search_outlined),
//                     ),
//                     SizedBox(
//                       height: AppSizeHeight.s12,
//                     ),
//                     Text(
//                       "Çok Satanlar",
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                             fontWeight: FontWeightManager.semiBold,
//                           ),
//                     ),
//                     SizedBox(
//                       height: AppSizeHeight.s12,
//                     ),
//                     GridView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 3, // Number of columns
//                           mainAxisSpacing: 8,
//                           crossAxisSpacing: 8),
//                       itemCount: state.bestBook!.length,
//                       itemBuilder: (context, index) =>
//                           _buildBookItem(state.bestBook![index]),
//                     ),
//                   ],
//                 );
//               }
//               if (state is RemoteBestSellerBookError) {
//                 return Center(
//                   child: Text(state.error.toString()),
//                 );
//               }

//               return SizedBox();
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBookItem(BookEntity book) {
//     return GestureDetector(
//       onTap: () {
//         // Handle onTap event for the grid item if needed
//       },
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             flex: 2,
//             child: book.items![0].volumeInfo!.imageLinks != null
//                 ? Image.network(
//                     book.items![0].volumeInfo!.imageLinks!.thumbnail!,
//                     fit: BoxFit
//                         .contain, // Ensure the image covers the entire area
//                   )
//                 : Icon(Icons.book),
//           ),
//           Padding(
//             padding: EdgeInsets.all(AppPadding.p8),
//             child: Text(
//                 textAlign: TextAlign.center,
//                 overflow: TextOverflow.ellipsis,
//                 book.items!.first.volumeInfo!.title ?? "N/A"),
//           )
//         ],
//       ),
//     );
//   }
// }
