import 'package:flutter_project/features/auth/data/data_source/remote/auth_data_source.dart';
import 'package:flutter_project/features/auth/domain/entity/user_entity.dart';
import 'package:flutter_project/features/auth/domain/repository/firebase_auth_repository.dart';

class FirebaseAuthRepositoryImpl implements FirebaseAuthRepository {
  final FirebaseAuthDataSource _dataSource;

  FirebaseAuthRepositoryImpl(this._dataSource);

  @override
  Future< void> signInWithEmailAndPassword(UserEntity user) async {
    return await _dataSource.signInWithEmailAndPassword(user);
  }

  @override
  Future<void> createUserWithEmailAndPassword(UserEntity user) async {
    return await _dataSource.createUserWithEmailAndPassword(user);
  }

  @override
  Future<void> signOut() async {
    await _dataSource.signOut();
  }
  
  @override
  Future<void> sendPasswordResetEmail(String email) async{
   return await _dataSource.sendPasswordResetEmail(email);
  }
  
  @override
  Future<void> createUser(UserEntity user) async{
       return await _dataSource.createUser(user);

  }
  
  @override
  Future<String> getCurrentUid() async {
       return await _dataSource.getCurrentUid();

  }
  
  @override
  Future<bool> isSignIn() async {
       return await _dataSource.isSignIn();

  }

  
  
  // @override
  // Future<void> signInWithGoogle() async {
  //   await _dataSource.signInWithGoogle();
  //   return null;
    
  // }

  
}
