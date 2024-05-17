part of 'remote_best_seller_book_cubit.dart';

sealed class RemoteBestSellerBookState extends Equatable {
    final List<BookEntity>? bestBook;
  final DioException? error;

  
  const RemoteBestSellerBookState(this.bestBook, this.error);

  @override
  List<Object> get props => [];
}



class RemoteBestSellerBookLoading extends RemoteBestSellerBookState{
  const RemoteBestSellerBookLoading() : super(null, null);
}

class RemoteBestSellerBookDone extends RemoteBestSellerBookState{
  const RemoteBestSellerBookDone(List<BookEntity>? bestBook) : super(bestBook, null);

}

class RemoteBestSellerBookError extends RemoteBestSellerBookState{
const RemoteBestSellerBookError(DioException error): super(null, error);
}