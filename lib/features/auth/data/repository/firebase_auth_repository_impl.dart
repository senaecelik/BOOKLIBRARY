import 'package:flutter_project/features/auth/data/data_source/remote/auth_data_source.dart';
import 'package:flutter_project/features/auth/domain/repository/firebase_auth_repository.dart';

class FirebaseAuthRepositoryImpl implements FirebaseAuthRepository {
  final FirebaseAuthDataSource _dataSource;

  FirebaseAuthRepositoryImpl(this._dataSource);

  @override
  Future<ResponseModel?> signInWithEmailAndPassword(String email, String password) async {
    return await _dataSource.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<ResponseModel?> createUserWithEmailAndPassword(String userName, String email, String password) async {
    return await _dataSource.createUserWithEmailAndPassword( userName, email, password);
  }

  @override
  Future<void> signOut() async {
    await _dataSource.signOut();
  }
  
  @override
  Future<String?> sendPasswordResetEmail(String email) async{
   return await _dataSource.sendPasswordResetEmail(email);
  }
  
  @override
  Future<ResponseModel?> signInWithGoogle() async {
    await _dataSource.signInWithGoogle();
    return null;
    
  }

  
}
