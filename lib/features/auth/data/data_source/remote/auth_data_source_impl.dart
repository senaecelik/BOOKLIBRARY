import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_project/features/auth/data/data_source/remote/auth_data_source.dart';
import 'package:flutter_project/features/auth/data/models/user_model.dart';
import 'package:flutter_project/features/auth/domain/entity/user_entity.dart';
import 'package:flutter_project/features/auth/domain/entity/user_static_model.dart';

class FirebaseAuthDataSourceImpl extends FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  FirebaseAuthDataSourceImpl(this._firebaseAuth, this._firebaseFirestore);

  @override
  Future<String> getCurrentUid() async => _firebaseAuth.currentUser!.uid;

  @override
  Future<void> createUser(UserEntity user) async {
    final userCollection = _firebaseFirestore.collection("users");

    final uid = await getCurrentUid();

    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        uid: uid,
        name: user.name,
        email: user.email,
        username: user.username,
      ).toJson();

      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
      } else {
        userCollection.doc(uid).update(newUser);
      }

      
    }).catchError((error) {
      debugPrint("Some error occur");
    });
  }

  @override
  Future<void> createUserWithEmailAndPassword(UserEntity user) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(
              email: user.email!, password: user.password!)
          .then((currentUser) async {
        if (currentUser.user?.uid != null) {
          createUser(user);
        }
      });
      return;
    } catch (e) {
     
        rethrow;
      
    }
  }

  @override
   Future<bool> isSignIn() async => _firebaseAuth.currentUser?.uid != null;


  @override
  Future<void> sendPasswordResetEmail(String email)async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);

    } catch (e) {
     rethrow;
    }
  }

 @override
Future<void> signInWithEmailAndPassword(UserEntity user) async {
  try {
    if (user.email != null && user.password != null && user.email!.isNotEmpty && user.password!.isNotEmpty) {
      await _firebaseAuth.signInWithEmailAndPassword(email: user.email!, password: user.password!);

      // Giriş yapan kullanıcının bilgilerini statik modele kaydet
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        UserStaticModel.updateUser(UserEntity(
          uid: currentUser.uid,
          email: user.email,
          username: user.username,
          name: user.name,
        ));
      }
    } else {
      print("Email ve şifre alanları boş olamaz.");
    }
  } catch (e) {
    print("Oturum açma hatası: ${e.toString()}");
    rethrow; // Hata fırlatma
  }
}

  @override
  Future<void> signOut() async{
        await _firebaseAuth.signOut();

  }
}