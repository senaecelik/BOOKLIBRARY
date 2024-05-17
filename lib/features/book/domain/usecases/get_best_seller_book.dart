
import 'package:flutter_project/core/resources/data_state.dart';
import 'package:flutter_project/core/usecase/usecase.dart';
import 'package:flutter_project/features/book/domain/entities/best_seller_book.dart';
import 'package:flutter_project/features/book/domain/repository/best_seller_book_repository.dart';

class GetBestSellerBookUseCase implements UseCase<DataState<BestSellerBookEntity>, void>{
  
  final BestSellerBookRepository _bestSellerBookRepository;

  GetBestSellerBookUseCase(this._bestSellerBookRepository);
  
  @override
  Future<DataState<BestSellerBookEntity>> call({void params}) {
    return _bestSellerBookRepository.getBestSellerBooks();
  }

}