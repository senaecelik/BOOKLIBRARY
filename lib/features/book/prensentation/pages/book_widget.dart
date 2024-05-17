import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/features/book/prensentation/cubit/book/remote/remote_book/remote_book_cubit.dart';
import 'package:flutter_project/injection_container.dart';
import 'package:flutter_project/resources/values_manager.dart';

class BookWidget extends StatefulWidget {
  const BookWidget({Key? key}) : super(key: key);

  @override
  State<BookWidget> createState() => _BookWidgetState();
}

class _BookWidgetState extends State<BookWidget> {
  late RemoteBookCubit _remoteBookCubit;

  @override
  void initState() {
    super.initState();
    _remoteBookCubit = sl<RemoteBookCubit>();
    _remoteBookCubit.onGetBook(query: "fiction");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteBookCubit>.value(
      value: _remoteBookCubit,
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SearchBar(
          constraints: BoxConstraints(minHeight: 40),
          
          leading: IconButton(onPressed: (){}, icon: Icon(Icons.search )),
          
          hintText: "Kelime ya da isbn numarasına göre arama yapabilirsiniz",
          onSubmitted: (value) {
            _remoteBookCubit.onGetBook(query: value);
          },
        ),
        SizedBox(height: AppSizeHeight.s18,),
        BlocBuilder<RemoteBookCubit, RemoteBookState>(
          builder: (context, state) {
            if(state is RemoteBookInitial){
              return Text("Kitap bulunamadı");
            }
            if (state is RemoteBookLoading) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (state is RemoteBookDone) {
              return GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Number of columns
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8),
                itemCount: state.books!.items!.length,
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child:
                          state.books!.items![index].volumeInfo!.imageLinks !=
                                  null
                              ? Image.network(
                                  state.books!.items![index].volumeInfo!
                                      .imageLinks!.thumbnail!,
                                  fit: BoxFit
                                      .contain, // Ensure the image covers the entire area
                                )
                              : Icon(Icons.book),
                    ),
                    Padding(
                      padding: EdgeInsets.all(AppPadding.p8),
                      child: Text(
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          state.books!.items![index].volumeInfo!.title ??
                              "N/A"),
                    )
                  ],
                ),
              );
            }
            if (state is RemoteBookError) {
              return Center(
                child: IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {},
                ),
              );
            }

            return SizedBox();
          },
        ),
      ],
    );
  }
}
