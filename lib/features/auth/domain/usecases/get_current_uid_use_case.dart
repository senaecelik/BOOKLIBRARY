    
import 'package:flutter_project/core/usecase/usecase.dart';
import 'package:flutter_project/features/auth/domain/repository/firebase_auth_repository.dart';


class GetCurrentUidUseCase implements UseCase<String, void>{
  final FirebaseAuthRepository repository;

  GetCurrentUidUseCase( this.repository);

  @override
  Future<String> call([void params]) {
    return repository.getCurrentUid();
  }
}